import 'package:flutter/material.dart';
import 'package:sociabile/constants/global_variables.dart';
import 'package:sociabile/model/comment.dart';

class CommentCard extends StatelessWidget {
  final Comment comment;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  CommentCard({
    required this.comment,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: GlobalVariables.greyBackgroundCOlor,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  // backgroundImage: NetworkImage(comment.profileImageURL),
                  backgroundImage: null,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment.username,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: GlobalVariables.secondaryColor,
                      ),
                    ),
                    Text(
                      '${comment.major}',
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
                      onEdit();
                    } else if (value == 'delete') {
                      onDelete();
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
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 48.0),
              child: Text(
                comment.text,
                style: TextStyle(
                  color: GlobalVariables.subtitleColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
