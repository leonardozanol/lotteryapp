import 'package:flutter/material.dart';

class UtilsDecorator {
  AppBar appBar(String title, Color bgColor) {
    return AppBar(
      title: textModel(title, 20),

      backgroundColor: bgColor,
      centerTitle: true,
    );
  }

  Widget textModel(String text, double fSize) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fSize,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}
