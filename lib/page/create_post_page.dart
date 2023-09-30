import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sociabile/constants/global_variables.dart';

import '../services/post_services.dart';

class CreatePostPage extends StatefulWidget {
  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  TextEditingController _textEditingController = TextEditingController();
  File? _imageFile;

  Future<void> _getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      String? ext = pickedFile.path.split('.').last; // Get the file extension
      if (ext != 'jpg' && ext != 'jpeg' && ext != 'png') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Please select a jpg, jpeg, or png image.')));
        return;
      }

      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _submitPost() {
    if (_textEditingController.text.isNotEmpty) {
      final postService = PostService();
      if (_imageFile != null) {
        postService.createPost(
          context: context,
          title:
              "YourTitleHere", // This can be replaced by another text field capturing the post title
          content: _textEditingController.text,
          picturePath: _imageFile!.path,
        );
      } else {
        // Handle the scenario when no image is provided
        // This could involve another method on PostService or a modification of the createPost method.
      }

      // Optionally: After successfully adding the post, navigate back or show a success message
      // Navigator.pop(context); // to go back
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please provide post content.')));
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.backgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 80,
              ),
              TextField(
                controller: _textEditingController,
                maxLines: 5,
                style: TextStyle(
                  color: GlobalVariables.secondaryColor,
                  fontFamily: 'Poppins',
                ),
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
                ),
              ),
              SizedBox(height: 20),
              _imageFile != null
                  ? Image.file(
                      _imageFile!,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : SizedBox.shrink(),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _getImage,
                  child: Text(
                    'Select Image',
                    style: TextStyle(
                      color: GlobalVariables.greyBackgroundCOlor,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _submitPost,
                  child: Text(
                    'Submit Post',
                    style: TextStyle(
                      color: GlobalVariables.greyBackgroundCOlor,
                      fontFamily: 'Poppins',
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
