// 置き勉管理画面 の教材のボタン部分

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:okiben/customs.dart';

class OkibenItemTile extends StatelessWidget {
  const OkibenItemTile({
    required this.image,
    required this.title,
    required this.value,
    // required this.onChanged,
  });

  final String image;
  final String title;
  final bool value;
  // final void Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListTile(
        leading: Container(
          constraints: BoxConstraints(
            maxHeight: 100.0,
          ),
          child: Image.asset(
            image,
            fit: BoxFit.contain,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: okibenItemTileTitleSize()),
        ),
        trailing: Transform.scale(
          scale: 1.3,
          child: CupertinoSwitch(
            value: value,
            onChanged: null,
          ),
        ),
      ),
      padding: EdgeInsets.fromLTRB(5, 20, 10, 20),
      margin: EdgeInsets.only(
          top: okibenItemTileMergeTBSize(),
          bottom: okibenItemTileMergeTBSize()),
      decoration: BoxDecoration(
        border: Border.all(color: itemTileColor(), width: 1), // 枠線
        borderRadius: BorderRadius.circular(8), // 角丸
      ),
    );
  }
}
