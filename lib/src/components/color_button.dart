import 'package:flutter/material.dart';

class ColorButton extends StatelessWidget {
  final int colorCode;
  const ColorButton({super.key, required this.colorCode});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 3),
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
        color: Color(colorCode),
      ),
    );
  }
}
