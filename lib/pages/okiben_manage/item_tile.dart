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
    required this.onNameChanged
  });

  final String image;
  final String title;
  final bool value;
  final void Function(bool)? onChanged;
  final void Function(String) onNameChanged;

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
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              String newName = title;
              return AlertDialog(
                title: Text("編集"),
                content: TextField(
                  style: TextStyle(fontSize: 23),
                  decoration: InputDecoration(labelText: '元の名前：$title'),
                  onChanged: (value) {
                    newName = value; // テキストフィールドの変更を反映
                  },
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'キャンセル',
                      style: okibenItemDialogActionsTextStyle('red'),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, newName); // 新しい名前を返す
                    },
                    child: Text(
                      '保存',
                      style: okibenItemDialogActionsTextStyle(''),
                    ),
                  ),
                ],
              );
            },
          ).then((newName) {
            if (newName != null && newName.isNotEmpty) {
              onNameChanged(newName);
            }
          });
        },
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
          bottom: okibenItemTileMergeTBSize()),
    );
  }
}
