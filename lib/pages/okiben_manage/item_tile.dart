// 置き勉管理画面 の教材のボタン部分
// okiben_manage.dartで利用
// flutter run -d chrome lib/pages/okiben_manage/okiben_manage.dart

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:okiben/components/comp_close_circle_button.dart';
import 'package:okiben/components/comp_common_dialog.dart';
import 'package:okiben/components/comp_common_button.dart';
import 'package:okiben/components/comp_target_display.dart';
import 'package:okiben/customs.dart';
import 'package:okiben/components/comp_operation_tile.dart';



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
      margin: EdgeInsets.symmetric(vertical: okibenItemTileMergeTBSize()),
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
                  overflow: TextOverflow.ellipsis,
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
              return CompCommonDialog(
                title: '操作',
                contentChildren: [
                  CompTargetDisplay(
                    title: '操作対象',
                    displayText: widget.title,
                  ),
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
                                  builder: (context, setState) {
                                    return CompCommonDialog(
                                      customHeight: 250,
                                      customWidth: 300,
                                      customContentMainAxisAlignment: MainAxisAlignment.start,
                                      title: '編集',
                                      contentChildren: [
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              CompTargetDisplay(
                                                title: '元の名前',
                                                displayText: widget.title,
                                              ),
                                              Column(children: [
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: Text('↓変更後の名前を入力', style: TextStyle(fontSize: 13), textAlign: TextAlign.left)
                                                ),
                                                SizedBox(height: 2),
                                                TextFormField(
                                                  maxLines: null,
                                                  keyboardType: TextInputType.text,
                                                  style: TextStyle(fontSize: 16),
                                                  initialValue: widget.title,
                                                  decoration: InputDecoration(
                                                    hintText: '未入力',
                                                    hintStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.red),
                                                    filled: true,
                                                    fillColor: Theme.of(context).brightness == Brightness.light
                                                      ? Color(0xfffefefe)
                                                      : dialogBackColorLight()
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      newName = value; // 変更後の名前を更新
                                                    });
                                                  },
                                                ),
                                              ]),
                                              CompCommonButton(
                                                buttonText: '保存',
                                                onPressed: (newName.isNotEmpty && widget.title != newName)
                                                  ? () => Navigator.pop(context, newName)
                                                  : null,
                                                isDarkMode: (Theme.of(context).brightness == Brightness.light) ? false : true
                                              )
                                            ]
                                          ),
                                        )
                                      ]
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
                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    return CompCommonDialog(
                                      customHeight: 250,
                                      customWidth: 300,
                                      customContentMainAxisAlignment: MainAxisAlignment.start,
                                      title: '編集',
                                      contentChildren: [
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              CompTargetDisplay(
                                                title: '元のメモ',
                                                displayText: widget.memo,
                                              ),
                                              Column(children: [
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: Text('↓変更後のメモを入力', style: TextStyle(fontSize: 13), textAlign: TextAlign.left)
                                                ),
                                                SizedBox(height: 2),
                                                TextFormField(
                                                  maxLines: null,
                                                  keyboardType: TextInputType.text,
                                                  style: TextStyle(fontSize: 16),
                                                  initialValue: widget.title,
                                                  decoration: InputDecoration(
                                                    hintText: '未入力',
                                                    hintStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.red),
                                                    filled: true,
                                                    fillColor: Theme.of(context).brightness == Brightness.light
                                                      ? Color(0xfffefefe)
                                                      : dialogBackColorLight()
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      newMemo = value;
                                                    });
                                                  },
                                                ),
                                              ]),
                                              CompCommonButton(
                                                buttonText: '保存',
                                                onPressed: (newMemo.isNotEmpty && widget.title != newMemo)
                                                  ? () => Navigator.pop(context, newMemo)
                                                  : null,
                                                isDarkMode: (Theme.of(context).brightness == Brightness.light) ? false : true
                                              )
                                            ]
                                          ),
                                        )
                                      ]
                                    );
                                  },
                                );
                              },
                            ).then((newMemo) {
                              if (newMemo != null && newMemo.isNotEmpty) {
                                widget.onNameChanged(newMemo);
                              }
                            });
                          }
                        )
                      )
                      // =================================================================== メモボタン部分 終 ===================================================================
                    ],
                  )
                ],
                actionsChildren: [
                  // =================================================================== 削除ボタン部分 始 ===================================================================
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return CompCommonDialog(
                            customHeight: 250,
                            customContentMainAxisAlignment: MainAxisAlignment.spaceBetween,
                            title: '削除',
                            contentChildren: [
                              Text(
                                '本当に削除しますか？',
                                style: TextStyle(fontSize: 19),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    CompTargetDisplay(
                                      title: '削除対象',
                                      displayText: widget.title,
                                    ),
                                    CompCommonButton(
                                      buttonText: '完全に削除',
                                      customButtonColor: ( Theme.of(context).brightness == Brightness.light)
                                        ? Color.fromARGB(255, 234, 89, 89)
                                        : Color.fromARGB(255, 136, 66, 66),
                                      customWidth: 200,
                                      isDarkMode: (Theme.of(context).brightness == Brightness.light) ? false : true,
                                      onPressed: () {
                                        widget.delete(widget.indexNum); // 要素を削除する関数を呼び出す
                                        Navigator.pop(context);
                                      }
                                    )
                                  ]
                                ),
                              ),
                            ]
                          );
                        }
                      ).then((newName) {
                        if (newName != null && newName.isNotEmpty) {
                          widget.onNameChanged(newName);
                        }
                      });
                    },
                    icon: Icon(
                      Icons.delete_outline,
                      color: (Theme.of(context).brightness == Brightness.light)
                        ? Color(0xff808080)
                        : Color(0xffd0d0d0),
                    )
                  )
                  // =================================================================== 削除ボタン部分 終 ===================================================================
                ]
              );
            },
          );
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Color(0xfff3f3f3)
            : dialogBackColorDeep(),
          padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
          fixedSize: Size(double.infinity, 95),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
          ),
          side: BorderSide(
            color: itemTileColor(),
            width: 1,
          ),
        ),
      ),
    );
  }
}
