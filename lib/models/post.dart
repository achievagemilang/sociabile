import 'package:sociabile/model/post_display.dart';

class Post {
  final String id;
  final String title;
  final String content;
  final String photoUrl;
  final String photoPublicId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int userId;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.photoUrl,
    required this.photoPublicId,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      photoUrl: json['photoUrl'],
      photoPublicId: json['photoPublicId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      userId: json['userId'],
    );
  }

  PostDisplay toPostDisplay(String username, String major) {
    return PostDisplay(
      id: id,
      username: username,
      major: major,
      text: content,
      imageURL: photoUrl,
    );
  }
}
