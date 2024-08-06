// ビュー画面
// flutter run -d chrome lib/pages/okiben_manage/okiben_manage.dart

import 'package:flutter/material.dart';
import 'package:okiben/customs.dart';
import 'package:flutter/cupertino.dart';
import 'package:okiben/pages/view/caution.dart';
import 'package:okiben/pages/okiben_manage/okiben_manage.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

// void main() {
//   runApp(ViewPageHome());
// }

// class ViewPageHome extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: ViewPage(),
//     );
//   }
// }

class ViewPage extends StatefulWidget {
  @override
  _ViewPageState createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  bool _switchTrueValue = true;
  bool _switchFalseValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on_outlined,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black87 // ライトモードの色
                  : Colors.white, // ダークモードの色
            ),
            SizedBox(width: 5),
            Text('ビュー'),
          ],
        ),
        centerTitle: true,
        actions: [],
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor, // Themeから色を取得
      ),
      body: Consumer<OkibenManageModel>(
        builder: (context, model, child) {
          // ----------------------------------- 変数の処理 始　-----------------------------------
          final itemListInSchoolCount = model.itemList
              .where((element) =>
                  element['isOkiben'] == true)
              .length;
          print('itemListInSchoolCountは $itemListInSchoolCount');
          final itemListInHomeCount = model.itemList
              .where((element) =>
                  element['isOkiben'] == false)
              .length;
          print('itemListInHomeCountは $itemListInHomeCount');
          // ----------------------------------- 変数の処理 終　-----------------------------------

          return Padding(
            padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Column(
              children: [
                SizedBox(height: 8),
                // CautionWidget(
                //   cautionText: '持ち物がどこにあるか一目でわかります',
                //   backColor: Colors.black12,
                //   textSize: 15.0,
                //   cautionIcon: Icons.info_outlined,
                // ),
                // SizedBox(height: 5),
                // CautionWidget(
                //   cautionText: 'スクロール可能です',
                //   backColor: Colors.black12,
                //   textSize: 15.0,
                //   cautionIcon: Icons.info_outlined,
                // ),
                Wrap(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Theme.of(context).brightness == Brightness.light
                          ? Color(0xffededed) // ライトモードの色
                          : Color(0xff555555), // ダークモードの色
                      ),
                      padding: EdgeInsets.fromLTRB(10,8,8,8),
                      margin: EdgeInsets.only(left: 0, right: 0),
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 0),
                                  child: Icon(
                                    Icons.check,
                                    size: 20,
                                    color: Theme.of(context).brightness == Brightness.light
                                      ? Colors.black // ライトモードの色
                                      : Colors.white, // ダークモードの色
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      '持ち物がどこにあるか一目でわかります',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 0),
                                  child: Icon(
                                    Icons.check,
                                    size: 20,
                                    color: Theme.of(context).brightness == Brightness.light
                                      ? Colors.black // ライトモードの色
                                      : Colors.white, // ダークモードの色
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      'スクロール可能です',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Expanded(
                  child: model.itemList.isEmpty
                      ? Text(
                          '登録されている持ち物は0個です',
                          style: TextStyle(fontSize: 18),
                        )
                      : Column(
                          children: [
                            // ----------------------------------------------------- 学校にあるもの 始　-----------------------------------------------------
                            Row(children: [
                              Transform.scale(
                                child: CupertinoSwitch(
                                  value: _switchTrueValue,
                                  onChanged: (bool value) {
                                    // スイッチの状態を変更しないようにする
                                    setState(() {
                                      _switchTrueValue = true;
                                    });
                                  },
                                  activeColor: Color(0xff64c466),
                                ),
                                scale: 0.8,
                              ),
                              Text(
                                '学校にあるもの',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              )
                            ]),
                            SizedBox(height: 5),
                            Expanded(
                              child: itemListInSchoolCount == 0
                                  ? Text('該当する持ち物はありません')
                                  : Container(
                                    padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black38,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                      color: Theme.of(context).brightness == Brightness.light
                                        ? Colors.white // ライトモードの色
                                        : Color(0xff666666), // ダークモードの色
                                    ),
                                    child: Scrollbar(
                                      thumbVisibility: true,
                                      thickness: viewScrollBarThicknessSize(),
                                      child: ListView.builder(
                                        controller: ScrollController(),
                                        itemCount: model.itemList.length,
                                        itemBuilder: (context, index) {
                                          final itemListCopy =
                                            model.itemList[index];
                                          if (itemListCopy['isOkiben'] == true) {
                                          return Text(
                                            itemListCopy['name'] ?? '名前なし',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Theme.of(context).brightness == Brightness.light
                                                ? Colors.black
                                                : Colors.white,
                                            ),
                                          );
                                          } else {
                                          return SizedBox.shrink();// この条件分岐に到達することはあり得ないけどnull safetyのために書く
                                          }
                                        },
                                        ),
                                    ),
                                  ),
                                ),
                            // ----------------------------------------------------- 学校にあるもの 終　-----------------------------------------------------

                            // ----------------------------------------------------- 家にあるもの 始　-----------------------------------------------------
                            SizedBox(height: 15),
                            Row(children: [
                              Transform.scale(
                                child: CupertinoSwitch(
                                  value: _switchFalseValue,
                                  onChanged: (bool value) {
                                    // スイッチの状態を変更しないようにする
                                    setState(() {
                                      _switchFalseValue = false;
                                    });
                                  },
                                  activeColor: Color(0xff64c466),
                                ),
                                scale: 0.8,
                              ),
                              Text(
                                '家にあるもの',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              )
                            ]),
                            SizedBox(height: 5),
                            Expanded(
                              child: itemListInHomeCount == 0
                                  ? Text('該当する持ち物はありません')
                                  : Container(
                                    padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black38,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                      color: Theme.of(context).brightness == Brightness.light
                                        ? Colors.white // ライトモードの色
                                        : Color(0xff666666), // ダークモードの色
                                    ),
                                    child: Scrollbar(
                                      thumbVisibility: true,
                                      thickness: viewScrollBarThicknessSize(),
                                      child: ListView.builder(
                                        controller: ScrollController(),
                                          itemCount: model.itemList.length,
                                          itemBuilder: (context, index) {
                                            final itemListCopy =
                                                model.itemList[index];
                                            if (itemListCopy['isOkiben'] == false) {
                                              return Text(
                                                itemListCopy['name'] ?? '名前なし',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Theme.of(context).brightness == Brightness.light
                                                    ? Colors.black
                                                    : Colors.white,
                                                ),
                                              );
                                            } else {
                                              return SizedBox.shrink();// この条件分岐に到達することはあり得ないがnull safetyのために書く
                                            }
                                          },
                                        ),
                                    ),
                                  ),
                            ),
                            // ----------------------------------------------------- 家にあるもの 終　-----------------------------------------------------
                            SizedBox(height: 5),
                          ],
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
