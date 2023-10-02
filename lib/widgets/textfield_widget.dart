import 'package:flutter/material.dart';
import 'package:sociabile/constants/global_variables.dart';

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
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            color: GlobalVariables.purpleColor,
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
              borderSide: BorderSide(color: GlobalVariables.purpleColor),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: GlobalVariables.purpleColor),
            ),
          ),
          controller: controller,
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}
