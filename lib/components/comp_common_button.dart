// 保存ボタンのコンポーネント
import 'package:flutter/material.dart';


class CompCommonButton extends StatelessWidget {
  const CompCommonButton({super.key,
    required this.buttonText,
    required this.onPressed,
    this.customButtonColor,
    this.customWidth = 150
  });

  final String buttonText;
  final VoidCallback? onPressed;
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
          : (Theme.of(context).brightness == Brightness.light)
            ? Color(0xff555555)
            : Color(0xff606060),
        disabledBackgroundColor: (customButtonColor != null)
          ? customButtonColor!.withValues(alpha: 0.35)
          : (Theme.of(context).brightness == Brightness.light)
            ? Color(0xffcccccc)
            : Color(0xff373737),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: (onPressed == null)
            ? (Theme.of(context).brightness == Brightness.light)    // 非活性の時のテキスト色
              ? Colors.white
              : Color(0xff888888)
            : (Theme.of(context).brightness == Brightness.light)    // 活性の時のテキスト色
              ? Colors.white
              : Colors.white,
        ),
      ),
    );
  }
}
