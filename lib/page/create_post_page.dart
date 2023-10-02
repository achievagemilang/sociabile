// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sociabile/constants/global_variables.dart';

import '../services/post_services.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final TextEditingController _textEditingController = TextEditingController();
  File? _imageFile;

  Future<void> _getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      String? ext = pickedFile.path.split('.').last; // Get the file extension
      if (ext != 'jpg' && ext != 'jpeg' && ext != 'png') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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
          imageFile: _imageFile!,
        );
      } else {
        // Handle the scenario when no image is provided
        // This could involve another method on PostService or a modification of the createPost method.
      }

      // Optionally: After successfully adding the post, navigate back or show a success message
      // Navigator.pop(context); // to go back
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please provide post content.')));
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
        padding: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 80,
              ),
              TextField(
                controller: _textEditingController,
                maxLines: 5,
                style: const TextStyle(
                  color: GlobalVariables.secondaryColor,
                  fontFamily: 'Poppins',
                ),
                decoration: const InputDecoration(
                  hintText: 'Type your content...',
                  hintStyle: TextStyle(color: GlobalVariables.secondaryColor),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: GlobalVariables.subtitleColor,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: GlobalVariables.subtitleColor,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
              ),
              const SizedBox(height: 20),
              _imageFile != null
                  ? Image.file(
                      _imageFile!,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : const SizedBox.shrink(),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _getImage,
                  child: const Text(
                    'Select Image',
                    style: TextStyle(
                      color: GlobalVariables.greyBackgroundCOlor,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _submitPost,
                  child: const Text(
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
