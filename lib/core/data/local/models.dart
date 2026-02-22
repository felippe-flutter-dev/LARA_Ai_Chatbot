class ConversationEntity {
  final int? id;
  final String userId;
  final String title;
  final String lastMessage;
  final int createdAt;
  final int updateAt;

  ConversationEntity({
    this.id,
    required this.userId,
    required this.title,
    this.lastMessage = '',
    required this.createdAt,
    required this.updateAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'lastMessage': lastMessage,
      'createdAt': createdAt,
      'updateAt': updateAt,
    };
  }

  factory ConversationEntity.fromMap(Map<String, dynamic> map) {
    return ConversationEntity(
      id: map['id'],
      userId: map['userId'] ?? '',
      title: map['title'] ?? '',
      lastMessage: map['lastMessage'] ?? '',
      createdAt: map['createdAt'] ?? 0,
      updateAt: map['updateAt'] ?? 0,
    );
  }
}

class MessageEntity {
  final int? id;
  final int conversationId;
  final String text;
  final bool isUser;
  final int createdAt;

  MessageEntity({
    this.id,
    required this.conversationId,
    required this.text,
    required this.isUser,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'conversationId': conversationId,
      'text': text,
      'isUser': isUser ? 1 : 0,
      'createdAt': createdAt,
    };
  }

  factory MessageEntity.fromMap(Map<String, dynamic> map) {
    return MessageEntity(
      id: map['id'],
      conversationId: map['conversationId'],
      text: map['text'],
      isUser: map['isUser'] == 1,
      createdAt: map['createdAt'],
    );
  }
}
