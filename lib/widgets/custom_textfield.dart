import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  const CustomTextfield(
      {super.key,
      required this.controller,
      required this.hintText,
      this.isPasswordField = false,
      this.maxLines = 1});
  final TextEditingController controller;
  final String hintText;
  final bool isPasswordField;
  final int maxLines;

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  bool isShowed = false;

  @override
  void initState() {
    super.initState();
    isShowed = widget.isPasswordField ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.hintText,
          style: const TextStyle(color: Colors.white),
        ),
        TextFormField(
          style: const TextStyle(color: Colors.white),
          obscureText: isShowed,
          controller: widget.controller,
          maxLines: widget.maxLines,
          decoration: InputDecoration(
            suffixIcon: widget.isPasswordField
                ? IconButton(
                    icon: Icon(
                      isShowed
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: const Color(0xFF353535),
                    ),
                    onPressed: () {
                      setState(() {
                        isShowed = !isShowed; // Toggle password visibility.
                      });
                    },
                  )
                : null,
            border: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF353535),
                ),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF353535),
                ),
                borderRadius: BorderRadius.all(Radius.circular(15))),
          ),
          validator: (val) {
            if (val == null || val.isEmpty) {
              return 'Enter your ${widget.hintText}';
            }
            return null;
          },
        ),
      ],
    );
  }
}
