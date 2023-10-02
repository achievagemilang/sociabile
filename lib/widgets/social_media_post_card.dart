// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:sociabile/constants/global_variables.dart';
import 'package:sociabile/model/post_display.dart';
import 'package:sociabile/page/comment_page.dart';

import '../services/post_services.dart';

class SocialMediaPostCard extends StatefulWidget {
  final PostDisplay post;
  final Function onPostDeleted;

  const SocialMediaPostCard(
      {super.key, required this.post, required this.onPostDeleted});

  @override
  State<SocialMediaPostCard> createState() => _SocialMediaPostCardState();
}

class _SocialMediaPostCardState extends State<SocialMediaPostCard> {
  void _showCommentsPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return CommentPage(
            comments: widget.post.comments,
            postCard: widget,
            postId: widget.post.id,
          );
        },
      ),
    ).then((_) => setState(() {}));
  }

  void _handleDeletePost(BuildContext context) {
    final postService = PostService();

    // Call the deletePost method from PostService
    postService.deletePost(
      context: context,
      postId: widget.post.id, // Use the post ID from the PostDisplay object
    );

    // Call the passed-in refresh callback function to update the list
    widget.onPostDeleted();
  }

  void _likePost(BuildContext context) {
    final postService = PostService();

    // Call the deletePost method from PostService
    postService.likeOrDislikePost(
      context: context,
      likeType: "LIKE",
      postId: widget.post.id, // Use the post ID from the PostDisplay object
    );

    widget.onPostDeleted();
  }

  void _handleEditPost(BuildContext context) {
    TextEditingController editController =
        TextEditingController(text: widget.post.text);

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: GlobalVariables.greyBackgroundCOlor,
            title:
                const Text('Edit Post', style: TextStyle(color: Colors.white)),
            content: TextField(
              style: const TextStyle(color: Colors.white),
              controller: editController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Edit post content...',
                hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.7)), // Hint text color
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white.withOpacity(0.7)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text(
                  'Update',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onPressed: () async {
                  final postService = PostService();
                  await postService.editPost(
                    context: context,
                    postId: widget.post.id,
                    title:
                        "title", // Replace with your title logic if there's any
                    content: editController.text,
                  );
                  Navigator.of(context).pop();
                  widget.onPostDeleted(); // To refresh after edit
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
      margin: const EdgeInsets.all(6.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(
          bottom: 8.0,
          top: 32.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Information (Profile Image, Username, Time Ago)
            Row(
              children: [
                const CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage("assets/RISTEK.png")),

                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post.username,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: GlobalVariables.secondaryColor,
                      ),
                    ),
                    Text(
                      widget.post.major,
                      style: const TextStyle(
                        color: GlobalVariables.subtitleColor,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
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
                    const PopupMenuItem<String>(
                      value: 'edit',
                      child: Text('Edit'),
                    ),
                    const PopupMenuItem<String>(
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
            const SizedBox(height: 30),
            // Post Text
            Text(
              widget.post.text,
              style: const TextStyle(
                fontSize: 14.0,
                color: GlobalVariables.subtitleColor,
              ),
            ),
            const SizedBox(height: 20),
            // Post Image
            Center(
              child: Container(
                width: 300,
                height: 150,
                decoration: BoxDecoration(
                  color:
                      Colors.grey, // Set a background color for the rectangle
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      10.0), // Clip the image to match the rectangle's border radius
                  child: Image.network(
                    widget.post.imageURL, // Replace with your image URL
                    fit: BoxFit
                        .cover, // Adjust the fit as needed (e.g., BoxFit.fill, BoxFit.contain)
                  ),
                ),
              ),
            ),
            // Comment and Like Icons
            const SizedBox(height: 10),
            // Like and Comment Icons with Counts
            Row(
              children: [
                IconButton(
                  color: GlobalVariables.subtitleColor,
                  icon: const Icon(Icons.favorite_border_outlined),
                  onPressed: () {
                    // Add your like action here
                    _likePost(context);
                  },
                ),
                Text(
                  (widget.post.likeCount - widget.post.dislikeCount).toString(),
                  style: const TextStyle(
                    color: GlobalVariables.subtitleColor,
                  ),
                ),
                const SizedBox(
                    width: 20), // Add spacing between like and comment counts
                IconButton(
                  icon: const Icon(Icons.mode_comment_outlined),
                  color: GlobalVariables.subtitleColor,
                  onPressed: () {
                    // Add your comment action here
                    _showCommentsPage(context);
                  },
                ),
                Text(
                  widget.post.comments.length.toString(),
                  style: const TextStyle(
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
