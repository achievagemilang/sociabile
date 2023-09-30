import 'package:flutter/material.dart';
import 'package:sociabile/constants/global_variables.dart';
import 'package:sociabile/model/post.dart';
import 'package:sociabile/page/comment_page.dart';

class SocialMediaPostCard extends StatelessWidget {
  final Post post;
  void _showCommentsPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return CommentPage(comments: post.comments, postCard: this);
        },
      ),
    );
  }

  SocialMediaPostCard({required this.post});

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
                    } else if (value == 'delete') {}
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
