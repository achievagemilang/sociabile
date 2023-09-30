import 'package:flutter/material.dart';
import 'package:sociabile/constants/global_variables.dart';
import 'package:sociabile/model/comment.dart';
import 'package:sociabile/widgets/comment_card.dart';
import 'package:sociabile/widgets/social_media_post_card.dart';

class CommentPage extends StatelessWidget {
  final SocialMediaPostCard postCard;
  final List<Comment> comments;

  CommentPage({
    required this.postCard,
    required this.comments,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Display the Post Card for the post you are commenting on
              postCard,
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
                children: comments.map((comment) {
                  return CommentCard(
                    comment: comment,
                    onEdit: () {
                      // Handle edit comment action
                    },
                    onDelete: () {
                      // Handle delete comment action
                    },
                  );
                }).toList(),
              ),
              // Comment TextField
              Padding(
                padding: EdgeInsets.all(16.0),
                child: TextField(
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
                      onPressed: () {
                        // Add your comment submission logic here
                      },
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
