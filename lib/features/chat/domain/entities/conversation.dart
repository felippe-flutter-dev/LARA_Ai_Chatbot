class Conversation {
  final int id;
  final String title;
  final String lastMessage;
  final int createdAt;
  final int updateAt;

  Conversation({
    required this.id,
    required this.title,
    required this.lastMessage,
    required this.createdAt,
    required this.updateAt,
  });
}
