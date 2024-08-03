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

TextStyle okibenItemDialogActionsTextStyle(String textColor) {
  if (textColor == 'red') {
    return TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: Colors.red,
    );
  } else {
    return TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
    );
  }
}
