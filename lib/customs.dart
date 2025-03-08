// フォント・色・大きさなどをこのファイルで指定して一括管理する
import 'package:flutter/material.dart';



Color itemTileColor() {
  final bottomIconButtonColor = Color(0xFF949494);
  return bottomIconButtonColor;
}

// OkibenItemTile系
double okibenItemTileMergeTBSize() {
  return 10.0;
}

double okibenItemTileTitleSize() {
  return 23.0;
}

double okibenItemTileMemoSize() {
  return 13.0;
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
  return Size(80, 120);
}

Color itemTileOperateButtonColor() {
  return Color(0xffe0e0e0);
}

Color itemTileOperateEditButtonColor({isDartMode=false}) {
  return (isDartMode) ? Color(0xffbac4ca) : Color(0xffeaf4fa);
}

Color itemTileOperateMemoButtonColor() {
  return Color(0xffe0e0ff);
}

Color itemTileOperateDeleteButtonColor() {
  return Color(0xffe0e0e0);
}

double viewScrollBarThicknessSize() {
  return 2.0;
}


// ダイアログの背景色(ダークモード時)
Color dialogBackColor() {
  return Color(0xff555555);
}
Color dialogBackColorDeep() {
  return Color(0xff444444);
}
Color dialogBackColorLight() {
  return Color(0xff777777);
}
// ダイアログの背景色(ライトモード時)
Color dialogLightColorDeep() {
  return Color(0xfff3f3f3);
}



// 設定のセクションタイトルの文字スタイル(ライトモード時)
TextStyle settingSectionTitleLight() {
  return TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
}

// 設定のセクションタイトルの文字スタイル(ダークモード時)
TextStyle settingSectionTitleDark() {
  return TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}



// 設定のキャプションの文字スタイル(ライトモード時)
TextStyle settingDescriptionLight() {
  return TextStyle(
    fontSize: 12,
    color: Colors.black,
  );
}

// 設定のキャプションの文字スタイル(ダークモード時)
TextStyle settingDescriptionDark() {
  return TextStyle(
    fontSize: 12,
    color: Color(0xffcccccc),
  );
}

// 追加ボタンの色
Color addIconButtonColor({isDarkMode=false}) {
  return (isDarkMode) ? Color(0xffe0e0e0) : Color(0xff404040);
}