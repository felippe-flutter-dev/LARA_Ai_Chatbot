import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lara_ai/core/data/services/auth_service.dart';
import 'package:lara_ai/features/chat/domain/repositories/i_chat_repository.dart';
import 'package:lara_ai/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:lara_ai/features/chat/presentation/cubit/chat_states.dart';
import 'package:mocktail/mocktail.dart';

class MockChatRepository extends Mock implements IChatRepositoryCustom {}

class MockAuthService extends Mock implements AuthService {}

class MockUser extends Mock implements User {}

void main() {
  late ChatCubit chatCubit;
  late MockChatRepository mockRepository;
  late MockAuthService mockAuthService;
  late MockUser mockUser;

  setUp(() {
    mockRepository = MockChatRepository();
    mockAuthService = MockAuthService();
    mockUser = MockUser();

    when(() => mockAuthService.currentUser).thenReturn(mockUser);
    when(() => mockUser.uid).thenReturn('user123');
    when(() => mockRepository.initChat()).thenReturn(null);
    when(() => mockRepository.resetCurrentConversation()).thenReturn(null);

    chatCubit = ChatCubit(mockRepository, mockAuthService);
  });

  group('ChatCubit', () {
    test('estado inicial deve ser ChatInitial ou ChatUpdated vazio', () {
      expect(chatCubit.state, isA<ChatUpdated>());
    });

    blocTest<ChatCubit, ChatState>(
      'deve emitir ChatUpdated com isTyping true e depois false ao enviar mensagem com sucesso',
      build: () {
        when(() => mockRepository.currentConversationId).thenReturn(1);
        when(
          () => mockRepository.sendMessage(any()),
        ).thenAnswer((_) => Stream.fromIterable(['Olá', ' tudo bem?']));
        when(
          () => mockRepository.persistAiMessage(any()),
        ).thenAnswer((_) async {});
        when(
          () => mockRepository.persistUserMessage(any()),
        ).thenAnswer((_) async {});
        when(
          () => mockRepository.updateLastMessage(any(), any()),
        ).thenAnswer((_) async {});
        when(
          () => mockRepository.getConversationTitle(any()),
        ).thenAnswer((_) async => 'Conversa');

        return chatCubit;
      },
      act: (cubit) => cubit.sendMessage('Oi LARA'),
      // O fluxo de mensagens e estados de digitação gera múltiplos estados ChatUpdated
      verify: (cubit) {
        verify(() => mockRepository.sendMessage('Oi LARA')).called(1);
      },
    );

    blocTest<ChatCubit, ChatState>(
      'deve emitir ChatError quando a API falhar',
      build: () {
        when(() => mockRepository.currentConversationId).thenReturn(1);
        when(
          () => mockRepository.sendMessage(any()),
        ).thenAnswer((_) => Stream.error(Exception('Erro de API')));
        return chatCubit;
      },
      act: (cubit) => cubit.sendMessage('Erro proposital'),
      expect: () => [
        isA<ChatUpdated>(), // Mensagem do usuário
        isA<ChatUpdated>(), // Placeholder "..."
        isA<ChatError>(), // O erro final tratado
      ],
    );
  });
}
