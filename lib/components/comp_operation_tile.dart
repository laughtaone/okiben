
import 'package:flutter/material.dart';



class CompOperationTile extends StatelessWidget {
  const CompOperationTile({super.key,
    required this.buttonText,
    required this.onPressed,
    this.detailText = '',
    this.centerText = ''
  });

  final String buttonText;
  final void Function() onPressed;
  final String detailText;
  final String centerText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: (Theme.of(context).brightness == Brightness.light)
            ? Color(0xffeeeeee)
            : Color(0xff464646),
          fixedSize: Size(double.infinity, 130),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // -------------- ヘッダー --------------
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                )
              ),
            ),
            // --------------------------------------
            // ------------- 真ん中の要素 -------------
            Row(
              children: [
                Flexible(child: Center(
                  child: Text(
                    centerText,
                    style: TextStyle(fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis
                  ),
                )),
              ]
            ),
            // --------------------------------------
            // -------------- フッター ---------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(child: Text(detailText, style: TextStyle(fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis)),
                Icon(Icons.chevron_right_outlined, size: 20)
              ]
            )
            // --------------------------------------
          ]
        )
      ),
    );
  }
}
