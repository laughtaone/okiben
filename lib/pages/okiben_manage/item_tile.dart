// 置き勉管理画面 の教材のボタン部分

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:okiben/customs.dart';

class OkibenItemTile extends StatelessWidget {
  const OkibenItemTile({
    required this.title,
    required this.value,
    // required this.onChanged,
  });

  final String title;
  final bool value;
  // final void Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: null,
        title: Text(
          title,
          style: TextStyle(fontSize: okibenItemTileTitleSize()),
        ),
        trailing: CupertinoSwitch(
          value: value,
          onChanged: null,
        ),
      ),
      margin: EdgeInsets.only(top: okibenItemTileMergeTBSize(), bottom: okibenItemTileMergeTBSize()),
      decoration: BoxDecoration(
        border: Border.all(color: itemTileColor(), width: 1),   // 枠線
        borderRadius: BorderRadius.circular(8),   // 角丸
      ),
    );
  }
}
