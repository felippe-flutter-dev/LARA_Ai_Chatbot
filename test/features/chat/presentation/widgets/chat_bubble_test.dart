import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lara_ai/features/chat/domain/entities/chat_message.dart';
import 'package:lara_ai/features/chat/presentation/pages/chat_view/chat_view_model.dart';
import 'package:lara_ai/features/chat/presentation/widgets/chat_bubble.dart';
import 'package:mocktail/mocktail.dart';

class MockChatViewModel extends Mock implements ChatViewModel {}

void main() {
  Widget makeTestableWidget(Widget child) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, _) => MaterialApp(home: Scaffold(body: child)),
    );
  }

  late MockChatViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockChatViewModel();
    // Stubbing the formatTime method to return a valid string
    when(() => mockViewModel.formatTime(any())).thenReturn('10:30');
  });

  group('ChatBubble Widget Tests', () {
    testWidgets('deve exibir a mensagem do usuário corretamente', (
      tester,
    ) async {
      final message = ChatMessage(
        text: 'Olá LARA',
        isUser: true,
        timestamp: DateTime(2023, 1, 1, 10, 30),
      );

      await tester.pumpWidget(
        makeTestableWidget(ChatBubble(message: message, vm: mockViewModel)),
      );
      await tester.pumpAndSettle();

      expect(find.text('Olá LARA'), findsOneWidget);
      expect(find.text('10:30'), findsOneWidget);
    });

    testWidgets('deve exibir a mensagem da LARA corretamente', (tester) async {
      final message = ChatMessage(
        text: 'Olá! Como posso ajudar?',
        isUser: false,
        timestamp: DateTime(2023, 1, 1, 10, 31),
      );

      // Re-stubbing for specific time if needed, otherwise uses the 10:30 from setUp
      when(() => mockViewModel.formatTime(any())).thenReturn('10:31');

      await tester.pumpWidget(
        makeTestableWidget(ChatBubble(message: message, vm: mockViewModel)),
      );
      await tester.pumpAndSettle();

      expect(find.text('Olá! Como posso ajudar?'), findsOneWidget);
      expect(find.text('10:31'), findsOneWidget);
    });
  });
}
