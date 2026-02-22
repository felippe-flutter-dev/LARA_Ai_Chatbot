import 'package:flutter_test/flutter_test.dart';
import 'package:lara_ai/core/data/local/conversation_dao.dart';
import 'package:lara_ai/core/data/local/models.dart';
import 'package:lara_ai/core/data/services/gemini_services.dart';
import 'package:lara_ai/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

class MockGeminiChatService extends Mock implements GeminiChatService {}

class MockConversationDao extends Mock implements ConversationDao {}

void main() {
  late ChatRepositoryImpl repository;
  late MockGeminiChatService mockService;
  late MockConversationDao mockDao;

  setUp(() {
    mockService = MockGeminiChatService();
    mockDao = MockConversationDao();
    repository = ChatRepositoryImpl(mockService, mockDao);
  });

  group('ChatRepository - Privacidade e Histórico', () {
    const tUserId = 'user_123';
    const tAnotherUserId = 'user_456';

    test(
      'deve passar o userId correto ao listar conversas para garantir privacidade',
      () async {
        // Arrange
        when(() => mockDao.listConversations(tUserId)).thenAnswer(
          (_) async => [
            ConversationEntity(
              id: 1,
              userId: tUserId,
              title: 'Minha Conversa',
              createdAt: 0,
              updateAt: 0,
            ),
          ],
        );

        // Act
        final result = await repository.listConversations(tUserId);

        // Assert
        expect(result.length, 1);
        expect(result.first.title, 'Minha Conversa');
        verify(() => mockDao.listConversations(tUserId)).called(1);
        verifyNever(() => mockDao.listConversations(tAnotherUserId));
      },
    );

    test(
      'deve carregar o histórico e inicializar a sessão da IA ao selecionar uma conversa',
      () async {
        // Arrange
        const tConversationId = 1;
        final tMessages = [
          MessageEntity(
            conversationId: tConversationId,
            text: 'Oi',
            isUser: true,
            createdAt: 0,
          ),
          MessageEntity(
            conversationId: tConversationId,
            text: 'Olá!',
            isUser: false,
            createdAt: 1,
          ),
        ];

        when(
          () => mockDao.getMessages(tConversationId),
        ).thenAnswer((_) async => tMessages);
        when(() => mockService.startChatFromMessages(any())).thenReturn(null);

        // Act
        await repository.selectConversation(tConversationId);

        // Assert
        verify(() => mockDao.getMessages(tConversationId)).called(1);
        verify(() => mockService.startChatFromMessages(any())).called(1);
      },
    );
  });
}
