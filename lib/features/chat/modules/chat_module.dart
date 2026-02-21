import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lara_ai/core/constants/route_names.dart';
import 'package:lara_ai/core/data/services/gemini_services.dart';
import 'package:lara_ai/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:lara_ai/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:lara_ai/features/chat/presentation/pages/chat_view/chat_view.dart';

class ChatModule extends Module {
  @override
  void binds(Injector i) {
    super.binds(i);
    i.addLazySingleton<GeminiChatService>(
      () => GeminiChatService(apiKey: dotenv.env['API_KEY']!),
    );
    i.addLazySingleton<ChatRepositoryImpl>(ChatRepositoryImpl.new);
    i.addLazySingleton<ChatCubit>(ChatCubit.new);
  }

  @override
  void routes(RouteManager r) {
    super.routes(r);
    r.child(RouteNames.chatPage, child: (context) => ChatView());
  }
}
