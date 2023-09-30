class Comment {
  final int id;
  final String value;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int userId;
  final String postId;

  Comment({
    required this.id,
    required this.value,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.postId,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      value: json['value'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      userId: json['userId'],
      postId: json['postId'],
    );
  }
}
