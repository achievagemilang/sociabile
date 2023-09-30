import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String text, bool isSuccess) {
  var snackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      titleFontSize: 20,
      messageFontSize: 15,
      title: isSuccess ? 'Success!' : 'On Snap!',
      color: isSuccess ? Colors.greenAccent : Colors.blue,
      message: text,
      contentType: isSuccess ? ContentType.success : ContentType.failure,
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
