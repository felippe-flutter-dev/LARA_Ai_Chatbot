import 'package:lara_ai/core/data/local/db.dart';
import 'package:lara_ai/core/data/local/models.dart';

class ConversationDao {
  final AppDatabase _dbProvider = AppDatabase();

  Future<int> createConversation(String title, String userId) async {
    final db = await _dbProvider.database;
    final now = DateTime.now().millisecondsSinceEpoch;
    final conv = ConversationEntity(
      userId: userId,
      title: title,
      createdAt: now,
      updateAt: now,
    );
    return await db.insert('conversations', conv.toMap());
  }

  Future<List<ConversationEntity>> listConversations(String userId) async {
    final db = await _dbProvider.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'conversations',
      where: 'userId = ?',
      whereArgs: [userId],
      orderBy: 'updateAt DESC',
    );
    return List.generate(
      maps.length,
      (i) => ConversationEntity.fromMap(maps[i]),
    );
  }

  Future<void> updateLastMessage(int id, String lastMessage) async {
    final db = await _dbProvider.database;
    await db.update(
      'conversations',
      {
        'lastMessage': lastMessage,
        'updateAt': DateTime.now().millisecondsSinceEpoch,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateConversationTitle(int id, String title) async {
    final db = await _dbProvider.database;
    await db.update(
      'conversations',
      {'title': title},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<ConversationEntity?> getConversation(int id) async {
    final db = await _dbProvider.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'conversations',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) return null;
    return ConversationEntity.fromMap(maps.first);
  }

  Future<void> deleteConversation(int id) async {
    final db = await _dbProvider.database;
    await db.delete('conversations', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> addMessage(MessageEntity message) async {
    final db = await _dbProvider.database;
    return await db.insert('messages', message.toMap());
  }

  Future<List<MessageEntity>> getMessages(int conversationId) async {
    final db = await _dbProvider.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'messages',
      where: 'conversationId = ?',
      whereArgs: [conversationId],
      orderBy: 'createdAt ASC',
    );
    return List.generate(maps.length, (i) => MessageEntity.fromMap(maps[i]));
  }
}
