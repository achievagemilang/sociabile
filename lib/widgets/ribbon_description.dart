import 'package:flutter/material.dart';
import 'package:sociabile/constants/global_variables.dart';

class RibbonDescription extends StatelessWidget {
  const RibbonDescription({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 16.0, top: 8.0, bottom: 16.0, right: 16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: GlobalVariables.purpleColor,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF10002B),
                  ),
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 17,
                      fontFamily: 'Poppins',
                      color: Color.fromARGB(255, 186, 186, 186),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
