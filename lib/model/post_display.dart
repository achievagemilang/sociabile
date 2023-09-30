import 'package:sociabile/model/comment_display.dart';

class PostDisplay {
  final String id;
  final String username;
  final String major;
  final String text;
  final String imageURL;
  List<CommentDisplay> comments;

  PostDisplay(
      {required this.id,
      required this.username,
      required this.major,
      required this.text,
      required this.imageURL,
      this.comments = const []});

  set setComments(List<CommentDisplay> comments) {
    this.comments = comments;
  }
}
