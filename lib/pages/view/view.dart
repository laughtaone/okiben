// ビュー画面
// flutter run -d chrome lib/pages/okiben_manage/okiben_manage.dart

import 'package:flutter/material.dart';
import 'package:okiben/customs.dart';
import 'package:flutter/cupertino.dart';
import 'package:okiben/pages/view/caution.dart';
import 'package:okiben/pages/okiben_manage/okiben_manage.dart';
import 'package:provider/provider.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on_outlined,
              color: Colors.black54,
            ),
            SizedBox(width: 5),
            Text('ビュー'),
          ],
        ),
        centerTitle: true,
        actions: [],
      ),
      // body: Padding(
      //   padding: const EdgeInsets.only(left: 18, right: 18, top: 10),
      //   child: Center(
      //     child: Column(
      //       children: [
      //         CautionWidget(cautionText:'持ち物がどこにあるか一目でわかります', backColor:Colors.black12, textSize:15.0, cautionIcon: Icons.check),
      //         SizedBox(height: 25),
      //         Row(
      //           children: [
      //             Container(
      //               child: Image.asset('assets/images/switch/switch_on.png'),
      //               width: 40,
      //             ),
      //             SizedBox(width: 10),
      //             Text(
      //               '学校にあるもの',
      //               style: TextStyle(
      //                 fontSize: 20
      //               ),
      //             ),
      //           ]
      //         )
      //       ],
      //     ),
      //   ),
      // ),
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
                CautionWidget(
                  cautionText: '持ち物がどこにあるか一目でわかります',
                  backColor: Colors.black12,
                  textSize: 15.0,
                  cautionIcon: Icons.info_outlined,
                ),
                SizedBox(height: 40),
                Expanded(
                  child: model.itemList.isEmpty
                      ? Text(
                          '登録されている持ち物は0個です',
                          style: TextStyle(fontSize: 18),
                        )
                      : Column(
                          children: [
                            Row(children: [
                              Container(
                                child: Image.asset(
                                    'assets/images/switch/switch_on.png'),
                                width: 40,
                              ),
                              SizedBox(width: 10),
                              Text(
                                '学校にあるもの',
                                style: TextStyle(fontSize: 20),
                              )
                            ]),
                            Expanded(
                              child: itemListInSchoolCount == 0
                                  ? Text('該当する持ち物はありません')
                                  : ListView.builder(
                                      itemCount: model.itemList.length,
                                      itemBuilder: (context, index) {
                                        final itemListCopy =
                                            model.itemList[index];
                                        if (itemListCopy['isOkiben'] == true) {
                                          return Text(
                                            itemListCopy['name'] ?? '名前なし',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black),
                                          );
                                        } else {
                                          return SizedBox.shrink();// この条件分岐に到達することはあり得ないけどnull safetyのために書く
                                        }
                                      },
                                    ),
                            ),
                            Row(children: [
                              Container(
                                child: Image.asset(
                                    'assets/images/switch/switch_off.png'),
                                width: 40,
                              ),
                              SizedBox(width: 10),
                              Text(
                                '家にあるもの',
                                style: TextStyle(fontSize: 20),
                              )
                            ]),
                            Expanded(
                              child: itemListInHomeCount == 0
                                  ? Text('該当する持ち物はありません')
                                  : ListView.builder(
                                      itemCount: model.itemList.length,
                                      itemBuilder: (context, index) {
                                        final itemListCopy =
                                            model.itemList[index];
                                        if (itemListCopy['isOkiben'] == false) {
                                          return Text(
                                            itemListCopy['name'] ?? '名前なし',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black),
                                          );
                                        } else {
                                          return SizedBox.shrink();// この条件分岐に到達することはあり得ないけどnull safetyのために書く
                                        }
                                      },
                                    ),
                            ),
                          ],
                        ),
                ),
              ],
            ),
          );
          // if (model.itemList.length >= 0) {
          // } else {
          //   return Center(
          //     child: Text('アイテムがありません'),
          //   );
          // }
        },
      ),
    );
  }
}
