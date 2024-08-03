// 置き勉管理画面 の教材のボタン部分
// okiben_manage.dartで利用
// flutter run -d chrome lib/pages/okiben_manage/okiben_manage.dart

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:okiben/customs.dart';

class OkibenItemTile extends StatelessWidget {
  const OkibenItemTile({
    required this.image,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final String image;
  final String title;
  final bool value;
  final void Function(bool)? onChanged;

  // int displayNum = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: OutlinedButton(
        child: Center(
          child: ListTile(
            // leading: Container(
            //   constraints: BoxConstraints(
            //     maxHeight: 100.0,
            //   ),
            //   child: Image.asset(
            //     image,
            //     fit: BoxFit.contain,
            //   ),
            // ),
            title: Text(
              title,
              style: TextStyle(fontSize: okibenItemTileTitleSize()),
            ),
            trailing: Transform.scale(
              scale: 1.3,
              child: CupertinoSwitch(
                value: value,
                onChanged: onChanged,
              ),
            ),
          ),
        ),
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.fromLTRB(5, 20, 10, 20),
          fixedSize: Size(double.infinity, 100),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // 角丸
          ),
          side: BorderSide(
            color: itemTileColor(), //枠線の色
            width: 1, //枠線の太さ
          ),
        ),
      ),
      margin: EdgeInsets.only(
        top: okibenItemTileMergeTBSize(),
        bottom: okibenItemTileMergeTBSize()
      ),
    );
  }
}
