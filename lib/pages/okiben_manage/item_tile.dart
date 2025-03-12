// 置き勉管理画面 の教材のボタン部分
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:okiben/components/comp_common_dialog.dart';
import 'package:okiben/components/comp_common_button.dart';
import 'package:okiben/components/comp_target_display.dart';
import 'package:okiben/components/comp_up_dialog.dart';
import 'package:okiben/customs.dart';
import 'package:okiben/components/comp_operation_tile.dart';
import 'package:okiben/pages/okiben_manage/okiben_manage.dart';
import 'package:provider/provider.dart';



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
            backgroundColor: (Theme.of(context).brightness == Brightness.light) ? Colors.white : Color(0xff303030),
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
                          String finalItemText = '';
                          Navigator.pop(context);
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: (Theme.of(context).brightness == Brightness.light) ? Colors.white : Color(0xff303030),
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
                                                // TextField(
                                                //   maxLines: null,
                                                //   keyboardType: TextInputType.text,
                                                //   focusNode: _focusNode,
                                                //   decoration: InputDecoration(
                                                //     border: InputBorder.none,
                                                //     contentPadding: const EdgeInsets.symmetric(horizontal: 20)
                                                //   ),
                                                //   onChanged: (value) {
                                                //     setState(() {
                                                //       newItemName = value;
                                                //     });
                                                //   },
                                                // ),
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
                                          isDarkMode: (Theme.of(context).brightness == Brightness.light) ? false : true
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



                        /*
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
                                    customHeight: null,
                                    customWidth: 300,
                                    customContentMainAxisAlignment: MainAxisAlignment.spaceAround,
                                    title: '編集',
                                    contentChildren: [
                                      CompTargetDisplay(
                                        title: '元の名前',
                                        displayText: widget.title,
                                      ),
                                      SizedBox(height: 30),
                                      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                                      SizedBox(height: 30),
                                      CompCommonButton(
                                        buttonText: '保存',
                                        onPressed: (newName.isNotEmpty && widget.title != newName)
                                          ? () => Navigator.pop(context, newName)
                                          : null,
                                        isDarkMode: (Theme.of(context).brightness == Brightness.light) ? false : true
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
                        */
                        // ------------------------------------------------------------------------------------------------
                      ),
                      // ======================================================================================================================================================

                      // =================================================================== メモボタン部分 始 ===================================================================
                      CompOperationTile(
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
                                    customHeight: null,
                                    customWidth: 300,
                                    customContentMainAxisAlignment: MainAxisAlignment.start,
                                    title: '編集',
                                    contentChildren: [
                                      CompTargetDisplay(
                                        title: '元のメモ',
                                        displayText: widget.memo,
                                      ),
                                      SizedBox(height: 30),
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
                                          initialValue: widget.memo,
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
                                      SizedBox(height: 30),
                                      CompCommonButton(
                                        buttonText: '保存',
                                        onPressed: (newMemo.isNotEmpty && widget.title != newMemo)
                                          ? () => Navigator.pop(context, newMemo)
                                          : null,
                                        isDarkMode: (Theme.of(context).brightness == Brightness.light) ? false : true
                                      )
                                    ]
                                  );
                                },
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
                    ],

                    /*
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
                    */
                  );
                }
              );



              /*
              return CompCommonDialog(
                customHeight: null,
                title: '操作',
                contentChildren: [
                  CompTargetDisplay(
                    title: '操作対象',
                    displayText: widget.title,
                  ),
                  SizedBox(height: 10),
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
                                      customHeight: null,
                                      customWidth: 300,
                                      customContentMainAxisAlignment: MainAxisAlignment.spaceAround,
                                      title: '編集',
                                      contentChildren: [
                                        CompTargetDisplay(
                                          title: '元の名前',
                                          displayText: widget.title,
                                        ),
                                        SizedBox(height: 30),
                                        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                                        SizedBox(height: 30),
                                        CompCommonButton(
                                          buttonText: '保存',
                                          onPressed: (newName.isNotEmpty && widget.title != newName)
                                            ? () => Navigator.pop(context, newName)
                                            : null,
                                          isDarkMode: (Theme.of(context).brightness == Brightness.light) ? false : true
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
                                      customHeight: null,
                                      customWidth: 300,
                                      customContentMainAxisAlignment: MainAxisAlignment.start,
                                      title: '編集',
                                      contentChildren: [
                                        CompTargetDisplay(
                                          title: '元のメモ',
                                          displayText: widget.memo,
                                        ),
                                        SizedBox(height: 30),
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
                                            initialValue: widget.memo,
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
                                        SizedBox(height: 30),
                                        CompCommonButton(
                                          buttonText: '保存',
                                          onPressed: (newMemo.isNotEmpty && widget.title != newMemo)
                                            ? () => Navigator.pop(context, newMemo)
                                            : null,
                                          isDarkMode: (Theme.of(context).brightness == Brightness.light) ? false : true
                                        )
                                      ]
                                    );
                                  },
                                );
                              },
                            ).then((newMemo) {
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
              */
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
