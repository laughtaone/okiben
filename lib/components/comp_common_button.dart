// 保存ボタンのコンポーネント
import 'package:flutter/material.dart';


class CompCommonButton extends StatelessWidget {
  const CompCommonButton({super.key,
    required this.buttonText,
    required this.onPressed,
    required this.isDarkMode,
    this.customButtonColor,
    this.customWidth = 150
  });

  final String buttonText;
  final VoidCallback? onPressed;
  final bool isDarkMode;
  final Color? customButtonColor;
  final double customWidth;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        fixedSize: Size(customWidth, 63),
        backgroundColor: (customButtonColor != null)
          ? customButtonColor
          : (!isDarkMode)
            ? Color.fromRGBO(85, 85, 85, 1)
            : Color.fromRGBO(140, 140, 140, 1),
        disabledBackgroundColor: (customButtonColor != null)
          ? customButtonColor!.withValues(alpha: 0.5)
          : (!isDarkMode)
            ? Color.fromRGBO(85, 85, 85, 0.1)
            : Color.fromRGBO(140, 140, 140, 0.25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
