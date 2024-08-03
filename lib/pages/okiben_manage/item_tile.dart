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
    required this.indexNum,
    required this.onChanged,
    required this.onNameChanged,
    required this.delete,
  });

  final String image;
  final String title;
  final bool value;
  final int indexNum;
  final void Function(bool)? onChanged;
  final void Function(String) onNameChanged;
  final void Function(int) delete;

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
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: okibenItemTileTitleSize()),
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
              return AlertDialog(
                title: Text("操作"),
                // content: TextField(
                //   style: TextStyle(fontSize: 23),
                //   decoration: InputDecoration(labelText: '元の名前：$title'),
                //   onChanged: (value) {
                //     newName = value; // テキストフィールドの変更を反映
                //   },
                // ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  String newName = title;
                                  return AlertDialog(
                                    title: Text("編集"),
                                    content: TextField(
                                      style: TextStyle(fontSize: 23),
                                      decoration: InputDecoration(
                                          labelText: '元の名前：$title'),
                                      onChanged: (value) {
                                        newName = value; // テキストフィールドの変更を反映
                                      },
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context),
                                        child: Text(
                                          'キャンセル',
                                          style:
                                              okibenItemDialogActionsTextStyle(
                                                  'red'),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(
                                              context, newName); // 新しい名前を返す
                                        },
                                        child: Text(
                                          '保存',
                                          style:
                                              okibenItemDialogActionsTextStyle(
                                                  ''),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              ).then((newName) {
                                if (newName != null && newName.isNotEmpty) {
                                  onNameChanged(newName);
                                }
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.edit_outlined,
                                  size: 40,
                                ),
                                Text('編集', style: TextStyle(fontSize: 20))
                              ],
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.yellow,
                              fixedSize: const Size(70, 90),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: TextButton(
                            onPressed: null,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_comment_outlined,
                                  size: 40,
                                ),
                                Text('メモ', style: TextStyle(fontSize: 20))
                              ],
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.yellow,
                              fixedSize: const Size(120, 90),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: TextButton(
                            onPressed: null,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.delete_outlined,
                                  size: 40,
                                ),
                                Text('削除', style: TextStyle(fontSize: 20))
                              ],
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.yellow,
                              fixedSize: const Size(70, 90),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),

                actions: [
                  // Row(
                  //   children: [
                  // TextButton(
                  //   onPressed: () {
                  //     delete(indexNum); // 要素を削除する関数を呼び出す
                  //     Navigator.pop(context);
                  //   },
                  //   child: Text(
                  //     '完全に削除',
                  //     style: okibenItemDialogActionsTextStyle('small-red'),
                  //   ),
                  // ),
                  // TextButton(
                  //   onPressed: () => Navigator.pop(context),
                  //   child: Text(
                  //     'キャンセル',
                  //     style: okibenItemDialogActionsTextStyle('red'),
                  //   ),
                  // ),
                  // TextButton(
                  //   onPressed: () {
                  //     Navigator.pop(context, newName); // 新しい名前を返す
                  //   },
                  //   child: Text(
                  //     '保存',
                  //     style: okibenItemDialogActionsTextStyle(''),
                  //   ),
                  // ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'キャンセル',
                      style: okibenItemDialogActionsTextStyle('red'),
                    ),
                  ),
                ],
                // ),
                // ],
              );
            },
          );
        },
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
          fixedSize: Size(double.infinity, 95),
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
