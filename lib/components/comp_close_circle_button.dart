// 丸い閉じるボタンのコンポーネント
import 'package:flutter/material.dart';


class CompCloseCircleButton extends StatelessWidget {
  const CompCloseCircleButton({super.key,
    required this.onPressed,
    this.customIconSize = 27         // アイコンサイズ(任意/デフォ値27)
  });

  final VoidCallback onPressed;
  final double customIconSize;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      style: IconButton.styleFrom(
        backgroundColor: (Theme.of(context).brightness == Brightness.light)
          ? Color(0xffe0e0e0)
          : Color(0xffa0a0a0)
      ),
      icon: Icon(Icons.close, size: customIconSize, color: Color(0xff000000))
    );
  }
}
