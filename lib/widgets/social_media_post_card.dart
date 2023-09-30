import 'package:flutter/material.dart';
import 'package:sociabile/constants/global_variables.dart';
import 'package:sociabile/model/post_display.dart';
import 'package:sociabile/page/comment_page.dart';
import 'package:sociabile/page/main_page.dart';

import '../services/post_services.dart';

class SocialMediaPostCard extends StatelessWidget {
  final PostDisplay post;
  final Function onPostDeleted;

  SocialMediaPostCard({required this.post, required this.onPostDeleted});

  void _showCommentsPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return CommentPage(
            comments: post.comments,
            postCard: this,
            postId: post.id,
          );
        },
      ),
    );
  }

  void _handleDeletePost(BuildContext context) {
    final postService = PostService();

    // Call the deletePost method from PostService
    postService.deletePost(
      context: context,
      postId: post.id, // Use the post ID from the PostDisplay object
    );

    // Call the passed-in refresh callback function to update the list
    onPostDeleted();
  }

  void _handleEditPost(BuildContext context) {
    TextEditingController editController =
        TextEditingController(text: post.text);

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Edit Post'),
            content: TextField(
              controller: editController,
              decoration: InputDecoration(hintText: "Edit your post content"),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Update'),
                onPressed: () async {
                  final postService = PostService();
                  await postService.editPost(
                    context: context,
                    postId: post.id,
                    title:
                        "title", // Replace with your title logic if there's any
                    content: editController.text,
                  );
                  Navigator.of(context).pop();
                  onPostDeleted(); // To refresh after edit
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: GlobalVariables.greyBackgroundCOlor,
      elevation: 4.0, // Add elevation for a card-like appearance
      margin: EdgeInsets.all(6.0),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0).copyWith(
          bottom: 8.0,
          top: 32.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Information (Profile Image, Username, Time Ago)
            Row(
              children: [
                Placeholder(
                  fallbackHeight: 40,
                  fallbackWidth: 40,
                  color: GlobalVariables.secondaryColor,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.username,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: GlobalVariables.secondaryColor,
                      ),
                    ),
                    Text(
                      post.major,
                      style: TextStyle(
                        color: GlobalVariables.subtitleColor,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                // Three Bullet Trailing Icons
                PopupMenuButton<String>(
                  color: GlobalVariables.subtitleColor,
                  onSelected: (value) {
                    if (value == 'edit') {
                      _handleEditPost(context);
                    } else if (value == 'delete') {
                      _handleDeletePost(context);
                    }
                  },
                  itemBuilder: (context) => <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: 'edit',
                      child: Text('Edit'),
                    ),
                    PopupMenuItem<String>(
                      value: 'delete',
                      child: Text(
                        'Delete',
                        style:
                            TextStyle(color: Color.fromARGB(255, 177, 91, 84)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            // Post Text
            Text(
              post.text,
              style: TextStyle(
                fontSize: 12.0,
                color: GlobalVariables.subtitleColor,
              ),
            ),
            SizedBox(height: 20),
            // Post Image
            Placeholder(
              fallbackHeight: 200,
              color: GlobalVariables.secondaryColor,
            ),
            // Comment and Like Icons
            SizedBox(height: 10),
            // Like and Comment Icons with Counts
            Row(
              children: [
                IconButton(
                  color: GlobalVariables.subtitleColor,
                  icon: Icon(Icons.favorite_border_outlined),
                  onPressed: () {
                    // Add your like action here
                  },
                ),
                Text(
                  '9',
                  style: TextStyle(
                    color: GlobalVariables.subtitleColor,
                  ),
                ),
                SizedBox(
                    width: 20), // Add spacing between like and comment counts
                IconButton(
                  icon: Icon(Icons.mode_comment_outlined),
                  color: GlobalVariables.subtitleColor,
                  onPressed: () {
                    // Add your comment action here
                    _showCommentsPage(context);
                  },
                ),
                Text(
                  '10',
                  style: TextStyle(
                    color: GlobalVariables.subtitleColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
