import 'db.dart';
import 'models.dart';

class ConversationDao {
  final AppDatabase _db = AppDatabase();

  Future<int> createConversation(String title) async {
    final db = await _db.database;
    final id = await db.insert('conversations', {
      'title': title,
      'lastMessage': '',
      'createdAt': DateTime.now().millisecondsSinceEpoch,
      'updateAt': DateTime.now().millisecondsSinceEpoch,
    });
    return id;
  }

  Future<List<ConversationEntity>> listConversations() async {
    final db = await _db.database;
    final rows = await db.query('conversations', orderBy: 'updateAt DESC');
    return rows.map((r) => ConversationEntity.fromMap(r)).toList();
  }

  Future<ConversationEntity?> getConversation(int id) async {
    final db = await _db.database;
    final rows = await db.query(
      'conversations',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return ConversationEntity.fromMap(rows.first);
  }

  Future<void> deleteConversation(int id) async {
    final db = await _db.database;
    await db.delete('messages', where: 'conversationId = ?', whereArgs: [id]);
    await db.delete('conversations', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> addMessage(MessageEntity message) async {
    final db = await _db.database;
    return await db.insert('messages', message.toMap());
  }

  Future<List<MessageEntity>> getMessages(int conversationId) async {
    final db = await _db.database;
    final rows = await db.query(
      'messages',
      where: 'conversationId = ?',
      whereArgs: [conversationId],
      orderBy: 'createdAt ASC',
    );
    return rows.map((r) => MessageEntity.fromMap(r)).toList();
  }

  Future<void> updateConversationTitle(int id, String title) async {
    final db = await _db.database;
    await db.update(
      'conversations',
      {'title': title, 'updateAt': DateTime.now().millisecondsSinceEpoch},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateLastMessage(int id, String message) async {
    final db = await _db.database;
    await db.update(
      'conversations',
      {
        'lastMessage': message,
        'updateAt': DateTime.now().millisecondsSinceEpoch,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
