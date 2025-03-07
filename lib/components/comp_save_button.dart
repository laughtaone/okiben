// 保存ボタンのコンポーネント
import 'package:flutter/material.dart';


class CompSaveButton extends StatelessWidget {
  const CompSaveButton({super.key,
    required this.onPressed,
    required this.isDarkMode
  });

  final VoidCallback? onPressed;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        fixedSize: Size(150, 63),
        backgroundColor: (!isDarkMode)
          ? Color.fromRGBO(85, 85, 85, 1)
          : Color.fromRGBO(140, 140, 140, 1),
        disabledBackgroundColor: (!isDarkMode)
          ? Color.fromRGBO(85, 85, 85, 0.1)
          : Color.fromRGBO(140, 140, 140, 0.25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text(
        '保存',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
