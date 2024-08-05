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
    required this.memo,
    required this.indexNum,
    required this.onChanged,
    required this.onNameChanged,
    required this.onMemoChanged,
    required this.delete,
  });

  final String image;
  final String title;
  final String memo;
  final bool value;
  final int indexNum;
  final void Function(bool)? onChanged;
  final void Function(String) onNameChanged;
  final void Function(String) onMemoChanged;
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
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: okibenItemTileTitleSize()
                  ),
                  softWrap: false,
                ),
                Text(
                  memo,
                  style: TextStyle(
                    fontSize: okibenItemTileMemoSize()
                  ),
                  maxLines: 2,
                )
              ],
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
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // =================================================================== 編集ボタン部分 始 ===================================================================
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
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("編集"),
                                          SizedBox(height: 6),
                                          Text(
                                            '元の名前：$title',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      content: TextFormField(
                                        style: TextStyle(fontSize: 23),
                                        initialValue: title,
                                        decoration: InputDecoration(
                                            labelText: '変更後の名前を入力'),
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
                                  }).then((newName) {
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
                              backgroundColor: itemTileOperateEditButtonColor(),
                              fixedSize: itemTileOperateButtonSize(),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        // =================================================================== 編集ボタン部分 終 ===================================================================

                        SizedBox(width: 12),

                        // =================================================================== メモボタン部分 始 ===================================================================
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    String newMemo = memo;
                                    return AlertDialog(
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("メモ"),
                                          SizedBox(height: 6),
                                          Text(
                                            '元のメモ：$memo',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      content: TextFormField(
                                        style: TextStyle(fontSize: 23),
                                        initialValue: memo,
                                        decoration: InputDecoration(
                                          labelText: '変更後の名前を入力'
                                        ),
                                        onChanged: (value) {
                                          newMemo = value; // テキストフィールドの変更を反映
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
                                                context, newMemo); // 新しい名前を返す
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
                                  }).then((newMemo) {
                                if (newMemo != null && newMemo.isNotEmpty) {
                                  onMemoChanged(newMemo);
                                }
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.local_offer_outlined,
                                  size: 40,
                                ),
                                Text('メモ', style: TextStyle(fontSize: 20))
                              ],
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: itemTileOperateMemoButtonColor(),
                              fixedSize: itemTileOperateButtonSize(),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        // =================================================================== メモボタン部分 終 ===================================================================

                        SizedBox(width: 12),

                        // =================================================================== 削除ボタン部分 始 ===================================================================
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              /*
                                onPressed: () {
                                  delete(indexNum); // 要素を削除する関数を呼び出す
                                  Navigator.pop(context);
                                },
                              */
                              Navigator.pop(context);
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("削除"),
                                          SizedBox(height: 6),
                                          Text(
                                            '本当に削除しますか？',
                                            style: TextStyle(fontSize: 19),
                                          ),
                                          SizedBox(height: 11),
                                          Text(
                                            '削除するアイテム名',
                                            style: TextStyle(fontSize: 15, color: Colors.black),
                                          ),
                                          SizedBox(height: 5),
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.black38,
                                                width: 0.5,
                                              ),
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.white,
                                            ),
                                            child: Center(
                                              child: Text(
                                                title
                                              ),
                                            ),
                                            height: 80,
                                          )
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text(
                                            'キャンセル',
                                            style:
                                                okibenItemDialogActionsTextStyle(''),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            delete(indexNum); // 要素を削除する関数を呼び出す
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            '完全に削除',
                                            style:
                                              okibenItemDialogActionsTextStyle('red'),
                                          ),
                                        ),
                                      ],
                                    );
                                  }).then((newName) {
                                if (newName != null && newName.isNotEmpty) {
                                  onNameChanged(newName);
                                }
                              });
                            },
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
                              backgroundColor: itemTileOperateDeleteButtonColor(),
                              fixedSize: itemTileOperateButtonSize(),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        // =================================================================== 削除ボタン部分 終 ===================================================================
                      ],
                    )
                  ],
                ),
                actions: [
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
          padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
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
