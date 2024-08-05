// フォント・色・大きさなどをこのファイルで指定して一括管理する

import 'package:flutter/material.dart';

// サンプル
/*
// BottomNavigationBarの各アイコンの色
// Color bottomIconButtonColor() {
//   final bottomIconButtonColor = Color(0xFF000000);
//   return bottomIconButtonColor;
// }
*/

Color itemTileColor() {
  final bottomIconButtonColor = Color(0xFF949494);
  return bottomIconButtonColor;
}

// OkibenItemTile系
double okibenItemTileMergeTBSize() {
  final okibenItemTileMergeTBSize = 10.0;
  return okibenItemTileMergeTBSize;
}

double okibenItemTileTitleSize() {
  final okibenItemTileTitleSize = 23.0;
  return okibenItemTileTitleSize;
}

double okibenItemTileMemoSize() {
  final okibenItemTileMemoSize = 13.0;
  return okibenItemTileMemoSize;
}

TextStyle okibenItemDialogActionsTextStyle(String textColor) {
  if (textColor == 'red') {
    return TextStyle(
      fontSize: 15.0,
      fontWeight: FontWeight.bold,
      color: Colors.red,
    );
  } else if (textColor == 'small-red') {
    return TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.bold,
      color: Color(0xfff08080),
    );
  } else {
    return TextStyle(
      fontSize: 15.0,
      fontWeight: FontWeight.bold,
    );
  }
}

Size itemTileOperateButtonSize() {
  final itemTileOperateButtonSize = Size(80, 90);
  return itemTileOperateButtonSize;
}

Color itemTileOperateButtonColor() {
  final itemTileOperateButtonColor = Color(0xffe0e0e0);
  return itemTileOperateButtonColor;
}

Color itemTileOperateEditButtonColor() {
  // final itemTileOperateButtonColor = Color(0xffe0e0ff);
  final itemTileOperateButtonColor = Color(0xffe0e0ff);
  return itemTileOperateButtonColor;
}

Color itemTileOperateMemoButtonColor() {
  // final itemTileOperateButtonColor = Color(0xffffffd0);
  final itemTileOperateButtonColor = Color(0xffe0e0ff);
  return itemTileOperateButtonColor;
}

Color itemTileOperateDeleteButtonColor() {
  final itemTileOperateButtonColor = Color(0xffe0e0e0);
  return itemTileOperateButtonColor;
}

double viewScrollBarThicknessSize() {
  final viewScrollBarThicknessSize = 2.0;
  return viewScrollBarThicknessSize;
}
