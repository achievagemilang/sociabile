import 'package:flutter/material.dart';
import 'package:sociabile/constants/global_variables.dart';
import 'package:sociabile/model/comment_display.dart';

class CommentCard extends StatelessWidget {
  final CommentDisplay comment;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const CommentCard({
    super.key,
    required this.comment,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: GlobalVariables.greyBackgroundCOlor,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage("assets/RISTEK.png"),
                ),

                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment.username,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: GlobalVariables.secondaryColor,
                      ),
                    ),
                    Text(
                      comment.major,
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
                      onEdit();
                    } else if (value == 'delete') {
                      onDelete();
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
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 48.0),
              child: Text(
                comment.text,
                style: const TextStyle(
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
