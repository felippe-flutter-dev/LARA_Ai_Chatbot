import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:lara_ai/core/widgets/enable_biometrics_dialog.dart';
import 'package:lara_ai/features/auth/presentation/pages/login/widgets/google_login_button.dart';
import 'package:lara_ai/core/widgets/logo_app.dart';
import 'package:lara_ai/features/chat/presentation/widgets/chat_text_field.dart';
import 'package:lara_ai/main.dart' as app;
import 'package:lucide_icons/lucide_icons.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('End-to-End Test', () {
    testWidgets('Fluxo completo: Splash -> Login -> Ativar Biometria -> Chat', (
      tester,
    ) async {
      // 1. Inicializa o app
      app.main();
      await tester.pumpAndSettle();

      // 2. Valida Splash
      expect(find.byType(LogoApp), findsOneWidget);

      // Aguarda a transição da Splash (2s + margem)
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();

      // 3. Verifica se chegou no Login e clica no botão do Google
      final googleBtn = find.byType(GoogleLoginButton);
      expect(googleBtn, findsOneWidget);
      await tester.tap(googleBtn);

      // Aguarda o processo de login e a aparição do diálogo de biometria
      bool dialogApareceu = false;
      for (int i = 0; i < 20; i++) {
        await tester.pump(const Duration(milliseconds: 500));
        if (find.byType(EnableBiometricsDialog).evaluate().isNotEmpty) {
          dialogApareceu = true;
          break;
        }
      }

      // 4. Interage com o diálogo de Ativar Biometria
      if (dialogApareceu) {
        expect(find.byType(EnableBiometricsDialog), findsOneWidget);

        final btnAtivarPt = find.text('Ativar Agora');
        final btnAtivarEn = find.text('Enable Now');

        if (btnAtivarPt.evaluate().isNotEmpty) {
          await tester.tap(btnAtivarPt);
        } else if (btnAtivarEn.evaluate().isNotEmpty) {
          await tester.tap(btnAtivarEn);
        }

        // Aguarda a biometria real e a transição para o Chat
        bool chegouNoChat = false;
        for (int i = 0; i < 60; i++) {
          await tester.pump(const Duration(milliseconds: 500));
          if (find.byType(ChatTextField).evaluate().isNotEmpty) {
            chegouNoChat = true;
            break;
          }
        }
        expect(chegouNoChat, isTrue);
        await tester.pumpAndSettle();
      }

      // 5. Verifica se chegou na tela de Chat
      final chatInput = find.byType(ChatTextField);
      expect(chatInput, findsOneWidget);

      // 6. Envia mensagem de teste
      const testMsg = 'Teste E2E finalizado com sucesso!';
      await tester.enterText(find.byType(TextField), testMsg);
      await tester.tap(find.byIcon(LucideIcons.send));

      // Aguarda a renderização da mensagem enviada e o início da resposta
      bool mensagemApareceu = false;
      for (int i = 0; i < 20; i++) {
        await tester.pump(const Duration(milliseconds: 500));
        if (find.textContaining(testMsg).evaluate().isNotEmpty) {
          mensagemApareceu = true;
          break;
        }
      }

      // 7. Valida se a mensagem está na tela
      expect(
        mensagemApareceu,
        isTrue,
        reason: "A mensagem enviada não foi encontrada na lista.",
      );
      await tester.pumpAndSettle();
    });
  });
}
