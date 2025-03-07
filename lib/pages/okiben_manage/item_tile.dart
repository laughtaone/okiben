// 置き勉管理画面 の教材のボタン部分
// okiben_manage.dartで利用
// flutter run -d chrome lib/pages/okiben_manage/okiben_manage.dart

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:okiben/components/comp_close_circle_button.dart';
import 'package:okiben/customs.dart';
import 'package:okiben/pages/okiben_manage/sub_comps/comp_operation_tile.dart';



class OkibenItemTile extends StatefulWidget {
  const OkibenItemTile({super.key,
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
  OkibenItemTileState createState() => OkibenItemTileState();
}


class OkibenItemTileState extends State<OkibenItemTile> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: OutlinedButton(
        child: Center(
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: okibenItemTileTitleSize()
                  ),
                  softWrap: false,
                ),
                Text(
                  widget.memo,
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
                value: widget.value,
                onChanged: widget.onChanged,
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
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("操作"),
                    CompCloseCircleButton(onPressed: () => Navigator.pop(context))
                  ],
                ),
                backgroundColor: Theme.of(context).brightness == Brightness.light
                  ? Colors.white // ライトモードの色
                  : dialogBackColor(), // ダークモードの色
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // =================================================================== 編集ボタン部分 始 ===================================================================
                        Expanded(
                          child: CompOperationTile(
                            buttonText: '編集',
                            icon: Icons.edit_outlined,
                            // ----------------------------------------- 編集ダイアログ -----------------------------------------
                            onPressed: () {
                              Navigator.pop(context);
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  String newName = widget.title;
                                  return StatefulBuilder(
                                    builder: (context, setState) { // StatefulBuilder で Dialog 内の setState を有効化
                                      return AlertDialog(
                                        backgroundColor: Theme.of(context).brightness == Brightness.light
                                          ? Colors.white // ライトモードの色
                                          : dialogBackColor(), // ダークモードの色
                                        content: SizedBox(
                                          width: 250,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text("編集", style: TextStyle(fontSize: 22)),
                                                  CompCloseCircleButton(onPressed: () => Navigator.pop(context))
                                                ],
                                              ),
                                              SizedBox(height: 15),
                                              Container(
                                                width: double.infinity,
                                                height: 43,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Color(0xffF3F3F3)
                                                ),
                                                padding: EdgeInsets.symmetric(horizontal: 17),
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        '元の名前',
                                                        style: TextStyle(fontSize: 15, color: Colors.black),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                      SizedBox(width: 10),
                                                      Expanded(
                                                        child: SelectableText(
                                                          widget.title,
                                                          style: TextStyle(fontSize: 16, color: Colors.black),
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 25),
                                              SizedBox(
                                                width: double.infinity,
                                                child: Text('↓変更後の名前を入力', style: TextStyle(fontSize: 13), textAlign: TextAlign.left)
                                              ),
                                              SizedBox(height: 2),
                                              TextFormField(
                                                style: TextStyle(fontSize: 16),
                                                initialValue: widget.title,
                                                decoration: InputDecoration(
                                                  hintText: '未入力',
                                                  hintStyle: const TextStyle(fontSize: 15),
                                                  fillColor: const Color(0xfffefefe),
                                                  filled: true,
                                                ),
                                                onChanged: (value) {
                                                  setState(() {
                                                    newName = value; // 変更後の名前を更新
                                                  });
                                                },
                                              ),
                                              SizedBox(height: 35),
                                              SizedBox(
                                                width: 150,
                                                height: 55,
                                                child: TextButton(
                                                  onPressed: (newName.isNotEmpty && widget.title != newName)
                                                    ? () => Navigator.pop(context, newName)
                                                    : null,
                                                  style: TextButton.styleFrom(
                                                    disabledBackgroundColor: Color.fromRGBO(115, 115, 115, 0.1),
                                                    backgroundColor: Color.fromRGBO(115, 115, 115, 1),
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
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ).then((newName) {
                                if (newName != null && newName.isNotEmpty) {
                                  widget.onNameChanged(newName);
                                }
                              });
                            },
                            // ------------------------------------------------------------------------------------------------
                          )
                        ),
                        // =================================================================== 編集ボタン部分 終 ===================================================================

                        SizedBox(width: 12),

                        // =================================================================== メモボタン部分 始 ===================================================================
                        Expanded(
                          child: CompOperationTile(
                            buttonText: 'メモ',
                            icon: Icons.local_offer_outlined,
                            onPressed: () {
                              Navigator.pop(context);
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    String newMemo = widget.memo;
                                    return AlertDialog(
                                      backgroundColor: Theme.of(context).brightness == Brightness.light
                                        ? Colors.white // ライトモードの色
                                        : dialogBackColor(), // ダークモードの色
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("メモ"),
                                          SizedBox(height: 6),
                                          Text(
                                            '元のメモ：${widget.memo}',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      content: TextFormField(
                                        style: TextStyle(fontSize: 23),
                                        initialValue: widget.memo,
                                        decoration: InputDecoration(
                                          labelText: '変更後の名前を入力'
                                        ),
                                        onChanged: (value) {
                                          newMemo = value; // テキストフィールドの変更を反映
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
                                  widget.onMemoChanged(newMemo);
                                }
                              });
                            }
                          )
                        )
                        // =================================================================== メモボタン部分 終 ===================================================================
                      ],
                    )
                  ],
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Theme.of(context).brightness == Brightness.light
                                ? Colors.white // ライトモードの色
                                : dialogBackColor(), // ダークモードの色
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
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Theme.of(context).brightness == Brightness.light
                                        ? Colors.black // ライトモードの色
                                        : Colors.white, // ダークモードの色
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Theme.of(context).brightness == Brightness.light
                                          ? Colors.black // ライトモードの色
                                          : Colors.white, // ダークモードの色
                                        width: 0.5,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                      color: Theme.of(context).brightness == Brightness.light
                                        ? Colors.white // ライトモードの色
                                        : Color(0xff666666), // ダークモードの色
                                    ),
                                    child: Center(
                                      child: Text(
                                        widget.title
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
                                    widget.delete(widget.indexNum); // 要素を削除する関数を呼び出す
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
                          widget.onNameChanged(newName);
                        }
                      });
                    },
                    icon: Icon(
                      Icons.delete_outline,
                      color: Color(0xff808080),
                    )
                  )
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
