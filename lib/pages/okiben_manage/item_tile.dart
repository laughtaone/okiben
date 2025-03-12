// 置き勉管理画面 の教材のボタン部分
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:okiben/components/comp_common_dialog.dart';
import 'package:okiben/components/comp_common_button.dart';
import 'package:okiben/components/comp_target_display.dart';
import 'package:okiben/components/comp_up_dialog.dart';
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
  // -------------- 追加するアイテム名スクロールバー用 --------------
  final ScrollController _scrollController = ScrollController();
  // ----------------------------------------------------------
  // ------------ 追加するアイテム名 テキストフィールド用 ------------
  bool isSelectTextField = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          isSelectTextField = true;
        });
      } else {
        setState(() {
          isSelectTextField = false;
        });
      }
    });
  }
  // ----------------------------------------------------------
  // ------------------------ dispose系 ------------------------
  @override
  void dispose() {
    _scrollController.dispose();
    _focusNode.dispose();  // 不要になったFocusNodeを解放
    super.dispose();
  }
  // ----------------------------------------------------------





  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: okibenItemTileMergeTBSize()),
      child: OutlinedButton(
        onPressed: () {
          double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
          bool isSEModel = (MediaQuery.of(context).size.width / MediaQuery.of(context).size.height - 16 / 9).abs() < 1.22;
          double focusedDialogHeight = (isSEModel) ? 0.9 : 0.8;
          double unfocusedDialogHeight = (isSEModel) ? 0.6 : 0.5;
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setState) {
                  return CompUpDialog(
                    keyboardHeight: keyboardHeight,
                    initialChildSize: (isSelectTextField) ? focusedDialogHeight : unfocusedDialogHeight,
                    minChildSize: 0.4,
                    maxChildSize: (isSelectTextField) ? focusedDialogHeight : unfocusedDialogHeight,
                    dialogTitle: '⚒️ 操作',
                    dialogChildren: [
                      CompTargetDisplay(
                        title: '操作対象',
                        displayText: widget.title,
                      ),
                      SizedBox(height: 10),
                      // =================================================================== 編集ボタン部分 始 ===================================================================
                      CompOperationTile(
                        buttonText: '編集',
                        icon: Icons.edit_outlined,
                        // ----------------------------------------- 編集ダイアログ -----------------------------------------
                        onPressed: () {
                          String newName = '';
                          double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
                          bool isSEModel = (MediaQuery.of(context).size.width / MediaQuery.of(context).size.height - 16 / 9).abs() < 1.22;
                          double focusedDialogHeight = (isSEModel) ? 0.92 : 0.82;
                          double unfocusedDialogHeight = (isSEModel) ? 0.6 : 0.5;
                          Navigator.pop(context);
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                            ),
                            builder: (context) {
                              return StatefulBuilder(
                                builder: (context, setState) {
                                  return CompUpDialog(
                                    keyboardHeight: keyboardHeight,
                                    initialChildSize: (isSelectTextField) ? focusedDialogHeight : unfocusedDialogHeight,
                                    minChildSize: 0.4,
                                    maxChildSize: (isSelectTextField) ? focusedDialogHeight : unfocusedDialogHeight,
                                    dialogTitle: '✏️ 編集',
                                    dialogChildren: [
                                      CompTargetDisplay(
                                        title: '元の名前',
                                        displayText: widget.title,
                                      ),
                                      SizedBox(height: 10),
                                      // - - - - - - 変更後のアイテム名を入力 - - - - - -
                                      Container(
                                        margin: const EdgeInsets.symmetric(vertical: 7),
                                        width: double.infinity,
                                        child: Text('↓ 変更後のアイテム名を入力', style: TextStyle(fontSize: 13), textAlign: TextAlign.left)
                                      ),
                                      // - - - - - - - - - - - - - - - - - - - - - - -
                                      // - - - - - - - - テキストフィールド - - - - - - -
                                      Container(
                                        constraints: BoxConstraints(maxHeight: 100),
                                        decoration: BoxDecoration(
                                          color: (Theme.of(context).brightness == Brightness.light) ? Colors.grey[200] : Color(0xff555555),
                                          borderRadius: BorderRadius.circular(17)
                                        ),
                                        padding: const EdgeInsets.only(right: 4),
                                        child: Scrollbar(
                                          controller: _scrollController,
                                          thumbVisibility: true,
                                          child: SingleChildScrollView(
                                            controller: _scrollController,
                                            child: Column(
                                              children: [
                                                SizedBox(height: 10),
                                                TextFormField(
                                                  maxLines: null,
                                                  keyboardType: TextInputType.text,
                                                  focusNode: _focusNode,
                                                  style: TextStyle(fontSize: 16),
                                                  initialValue: widget.title,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                                                    hintText: '未入力',
                                                    hintStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.red),
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      newName = value; // 変更後の名前を更新
                                                    });
                                                  },
                                                ),
                                                SizedBox(height: 10),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      // - - - - - - - - - - - - - - - - - - - - - - -
                                      SizedBox(height: 30),
                                      // - - - - - - - - - 変更ボタン - - - - - - - - - -
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 90),
                                        child: CompCommonButton(
                                          buttonText: '変更',
                                          onPressed: (newName.isNotEmpty && widget.title != newName)
                                            ? () => Navigator.pop(context, newName)
                                            : null,
                                        ),
                                      ),
                                      SizedBox(height: 30)
                                      // - - - - - - - - - - - - - - - - - - - - - - -
                                    ]
                                  );
                                }
                              );
                            },
                          ).then((newName) {
                            if (newName != null && newName.isNotEmpty) {
                              widget.onNameChanged(newName);
                            }
                          });
                        }
                        // ------------------------------------------------------------------------------------------------
                      ),
                      // ======================================================================================================================================================

                      // =================================================================== メモボタン部分 始 ===================================================================
                      CompOperationTile(
                        buttonText: 'メモ',
                        icon: Icons.local_offer_outlined,
                        onPressed: () {
                          String newMemo = '';
                          double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
                          bool isSEModel = (MediaQuery.of(context).size.width / MediaQuery.of(context).size.height - 16 / 9).abs() < 1.22;
                          double focusedDialogHeight = (isSEModel) ? 0.92 : 0.82;
                          double unfocusedDialogHeight = (isSEModel) ? 0.6 : 0.5;
                          Navigator.pop(context);
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                            ),
                            builder: (context) {
                              return StatefulBuilder(
                                builder: (context, setState) {
                                  return CompUpDialog(
                                    keyboardHeight: keyboardHeight,
                                    initialChildSize: (isSelectTextField) ? focusedDialogHeight : unfocusedDialogHeight,
                                    minChildSize: 0.4,
                                    maxChildSize: (isSelectTextField) ? focusedDialogHeight : unfocusedDialogHeight,
                                    dialogTitle: '📋 メモ',
                                    dialogChildren: [
                                      CompTargetDisplay(
                                        title: '元のメモ',
                                        displayText: widget.memo,
                                      ),
                                      SizedBox(height: 10),
                                      // - - - - - - - 変更後のメモを入力 - - - - - - - -
                                      Container(
                                        margin: const EdgeInsets.symmetric(vertical: 7),
                                        width: double.infinity,
                                        child: Text('↓ 変更後のメモを入力', style: TextStyle(fontSize: 13), textAlign: TextAlign.left)
                                      ),
                                      // - - - - - - - - - - - - - - - - - - - - - - -
                                      // - - - - - - - - テキストフィールド - - - - - - -
                                      Container(
                                        constraints: BoxConstraints(maxHeight: 100),
                                        decoration: BoxDecoration(
                                          color: (Theme.of(context).brightness == Brightness.light) ? Colors.grey[200] : Color(0xff555555),
                                          borderRadius: BorderRadius.circular(17)
                                        ),
                                        padding: const EdgeInsets.only(right: 4),
                                        child: Scrollbar(
                                          controller: _scrollController,
                                          thumbVisibility: true,
                                          child: SingleChildScrollView(
                                            controller: _scrollController,
                                            child: Column(
                                              children: [
                                                SizedBox(height: 10),
                                                TextFormField(
                                                  maxLines: null,
                                                  keyboardType: TextInputType.text,
                                                  focusNode: _focusNode,
                                                  style: TextStyle(fontSize: 16),
                                                  initialValue: widget.memo,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                                                    hintText: '未入力',
                                                    hintStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.red),
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      newMemo = value;
                                                    });
                                                  },
                                                ),
                                                SizedBox(height: 10),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      // - - - - - - - - - - - - - - - - - - - - - - -
                                      SizedBox(height: 30),
                                      // - - - - - - - - - 変更ボタン - - - - - - - - - -
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 90),
                                        child: CompCommonButton(
                                          buttonText: '変更',
                                          onPressed: (newMemo.isNotEmpty && widget.memo != newMemo)
                                            ? () => Navigator.pop(context, newMemo)
                                            : null,
                                        ),
                                      ),
                                      SizedBox(height: 30)
                                      // - - - - - - - - - - - - - - - - - - - - - - -
                                    ]
                                  );
                                }
                              );
                            },
                          ).then((newMemo) {
                            if (newMemo != null && newMemo.isNotEmpty) {
                              widget.onMemoChanged(newMemo);
                            }
                          });
                        }
                      ),
                      // ======================================================================================================================================================

                      SizedBox(width: 80),

                      // =================================================================== 削除ボタン部分 始 ===================================================================
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 120),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                              ),
                              builder: (context) {
                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    return CompUpDialog(
                                      keyboardHeight: keyboardHeight,
                                      initialChildSize: (isSelectTextField) ? focusedDialogHeight : unfocusedDialogHeight,
                                      minChildSize: 0.4,
                                      maxChildSize: (isSelectTextField) ? focusedDialogHeight : unfocusedDialogHeight,
                                      dialogTitle: '🗑️ 削除',
                                      dialogChildren: [
                                        // - - - - - - - 削除確認メッセージ - - - - - - - -
                                        Text(
                                          '本当に削除しますか？',
                                          style: TextStyle(fontSize: 19),
                                        ),
                                        Text('(下のボタンを押すと確認なしに削除を実行します)', style: TextStyle(fontSize: 14)),
                                        // - - - - - - - - - - - - - - - - - - - - - - -
                                        SizedBox(height: 15),
                                        // - - - - - - - - - 削除対象 - - - - - - - - - -
                                        CompTargetDisplay(
                                          title: '削除対象',
                                          displayText: widget.title,
                                        ),
                                        SizedBox(height: 10),
                                        // - - - - - - - - - - - - - - - - - - - - - - -
                                        SizedBox(height: 55),
                                        // - - - - - - - - テキストフィールド - - - - - - -
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 60),
                                          child: CompCommonButton(
                                            buttonText: '完全に削除',
                                            customButtonColor: ( Theme.of(context).brightness == Brightness.light)
                                              ? Color.fromARGB(255, 234, 89, 110)
                                              : Color(0xffaf4646),
                                            onPressed: () {
                                              widget.delete(widget.indexNum);
                                              Navigator.pop(context);
                                            }
                                          ),
                                        )
                                        // - - - - - - - - - - - - - - - - - - - - - - -
                                      ]
                                    );
                                  }
                                );
                              },
                            ).then((newMemo) {
                              if (newMemo != null && newMemo.isNotEmpty) {
                                widget.onMemoChanged(newMemo);
                              }
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.delete_outline),
                              SizedBox(width: 5),
                              Padding(
                                padding: EdgeInsets.only(top: 3),
                                child: Text('削除'),
                              ),
                            ],
                          ),
                          // )
                        ),
                      )
                      // ======================================================================================================================================================
                    ]
                  );
                }
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
      ),
    );
  }
}
