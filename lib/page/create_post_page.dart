import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sociabile/constants/global_variables.dart';

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

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  void _submitPost() {
    // Implement your post submission logic here
    // You can access the text content using _textEditingController.text
    // and the image (if selected) using _imageFile
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
