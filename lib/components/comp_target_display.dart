// 対象とするものを表示するコンポーネント
import 'package:flutter/material.dart';



class CompTargetDisplay extends StatelessWidget {
  const CompTargetDisplay({super.key,
    required this.title,
    required this.displayText
  });

  final String title;
  final String displayText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: (Theme.of(context).brightness == Brightness.light)
          ? Color(0xfff5f5f5)
          : Color(0xff3a3a3a),
      ),
      padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                (displayText == '') ? '未設定' : displayText,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: (displayText == '') ? Color(0xffb0b0b0) : null
                ),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        )
      ),
    );
  }
}