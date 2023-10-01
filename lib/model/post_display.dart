import 'package:sociabile/model/comment_display.dart';

class PostDisplay {
  final String id;
  final String username;
  final String major;
  final String text;
  final String imageURL;
  final int likeCount;
  final int dislikeCount;
  List<CommentDisplay> comments;

  PostDisplay(
      {required this.id,
      required this.username,
      required this.major,
      required this.text,
      required this.imageURL,
      required this.dislikeCount,
      required this.likeCount,
      this.comments = const []});

  set setComments(List<CommentDisplay> comments) {
    this.comments = comments;
  }

  @override
  String toString() {
    return 'PostDisplay{id: $id, username: $username, major: $major, text: $text, imageURL: $imageURL, comments: $comments}';
  }
}
