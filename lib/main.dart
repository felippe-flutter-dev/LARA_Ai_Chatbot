import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lara_ai/features/chat/data/presentation/pages/chat_view/chat_view.dart';
import 'core/data/services/gemini_services.dart';
import 'core/theme/theme_dark.dart';
import 'core/theme/theme_light.dart';
import 'features/chat/data/presentation/cubit/chat_cubit.dart';
import 'features/chat/data/repositories/chat_repository_impl.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await dotenv.load(fileName: ".env");

  // 1. Cria o SERVIÇO (O motor, a API pura)
  final geminiService = GeminiChatService(apiKey: dotenv.env['API_KEY']!);

  // 2. Cria o REPOSITÓRIO (A ponte, injetando o serviço nele)
  final chatRepository = ChatRepositoryImpl(geminiService);

  // 3. Inicializa o chat através do repositório
  chatRepository.initChat();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(
    BlocProvider(
      // 4. Injeta o REPOSITÓRIO no Cubit (Agora os tipos batem!)
      create: (context) => ChatCubit(chatRepository),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LARA AI',
      theme: AppThemeLight.theme,
      darkTheme: AppThemeDark.theme,
      themeMode: ThemeMode.system,
      home: const ChatView(),
    );
  }
}