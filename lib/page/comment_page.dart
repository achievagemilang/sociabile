import 'package:flutter/material.dart';
import 'package:sociabile/constants/global_variables.dart';
import 'package:sociabile/model/comment_display.dart';
import 'package:sociabile/services/comment_services.dart';
import 'package:sociabile/widgets/comment_card.dart';
import 'package:sociabile/widgets/social_media_post_card.dart';

import '../models/comment.dart';

class CommentPage extends StatefulWidget {
  final SocialMediaPostCard postCard;
  final List<CommentDisplay> comments;
  final String postId;

  CommentPage({
    required this.postCard,
    required this.comments,
    required this.postId,
  });

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final CommentService commentService = CommentService();
  final TextEditingController _commentController = TextEditingController();

  void _handleAddComment() async {
    if (_commentController.text.trim().isNotEmpty) {
      Comment? newComment = await commentService.postComment(
        context: context,
        value: _commentController.text,
        postId: widget.postId,
      );

      if (newComment != null) {
        setState(() {
          widget.comments.add(
            CommentDisplay(
              id: newComment.id,
              username:
                  "User ID ${newComment.userId}", // You'll need to replace this with the actual username
              major: "RISTEK 2023", // Replace this with the actual major
              text: newComment.value,
              profileImageURL:
                  'https://via.placeholder.com/150', // Replace this with the actual image URL
            ),
          );
          _commentController.clear(); // Clear the comment TextField
        });
      }
    }
  }

  void _handleEditComment(CommentDisplay comment) async {
    String? editedComment = await showDialog<String>(
      context: context,
      builder: (context) {
        TextEditingController editingController =
            TextEditingController(text: comment.text);
        return AlertDialog(
          backgroundColor: GlobalVariables.greyBackgroundCOlor,
          title: Text('Edit Comment', style: TextStyle(color: Colors.white)),
          content: TextField(
            style: TextStyle(color: Colors.white), // Text color for TextField
            controller: editingController,
            decoration: InputDecoration(
              hintText: 'Edit your comment...',
              hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.7)), // Hint text color
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white.withOpacity(0.7)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              child: Text('Cancel', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop(editingController.text);
              },
            ),
          ],
        );
      },
    );

    if (editedComment != null && editedComment != comment.text) {
      await commentService.editComment(
        context: context,
        value: editedComment,
        postId: widget.postId, // Make sure to provide the post ID here
        commentId: comment.id,
      );

      setState(() {
        comment.text = editedComment;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Display the Post Card for the post you are commenting on
              widget.postCard,
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Expanded(
                        child: Divider(
                      color: Color.fromARGB(255, 56, 56, 56),
                    )),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Comments",
                          style: const TextStyle(
                            color: Color.fromARGB(255, 56, 56, 56),
                          ),
                        )),
                    const Expanded(
                        child: Divider(
                      color: Color.fromARGB(255, 56, 56, 56),
                    )),
                  ],
                ),
              ), // Add a divider between the post and comments
              // Comment Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.comments.map((comment) {
                  return CommentCard(
                    comment: comment,
                    onEdit: () => _handleEditComment(comment),
                    onDelete: () {
                      commentService.deleteComment(
                          context: context, commentId: comment.id);
                      setState(() {
                        widget.comments.remove(
                            comment); // Remove the comment from the list after deletion
                      });
                    },
                  );
                }).toList(),
              ),
              // Comment TextField
              Padding(
                padding: EdgeInsets.all(16.0),
                child: TextField(
                  controller: _commentController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Add a comment...',
                    hintStyle: TextStyle(color: GlobalVariables.secondaryColor),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: GlobalVariables.subtitleColor,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: GlobalVariables.subtitleColor,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.send,
                        color: GlobalVariables.secondaryColor,
                      ),
                      onPressed: _handleAddComment,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
