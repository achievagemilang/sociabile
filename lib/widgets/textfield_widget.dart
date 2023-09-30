import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final String label;
  final int maxLines;
  final String text;
  final ValueChanged<String> onChanged;

  const TextFieldWidget({
    Key? key,
    this.maxLines = 1,
    required this.label,
    required this.onChanged,
    required this.text,
  }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            color: Color(0xFF9D4EDD),
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 8.0),
        TextField(
          style: const TextStyle(
              color: Color.fromARGB(255, 186, 186, 186), fontFamily: 'Poppins'),
          cursorColor: Colors.white,
          maxLines: widget.maxLines,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFF9D4EDD)),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF9D4EDD)),
            ),
          ),
          controller: controller,
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}
