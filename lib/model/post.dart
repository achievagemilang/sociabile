import 'package:sociabile/model/comment.dart';

class Post {
  final String username;
  final String major;
  final String text;
  final String imageURL;
  final List<Comment> comments;

  Post(
      {required this.username,
      required this.major,
      required this.text,
      required this.imageURL,
      required this.comments});
}
