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
          // 仮に1番目のアイテムが存在する場合に表示する
          if (model.itemList.length >= 0) {
            return Center(
              // child: Text(
              //   model.itemList[0]['name'],
              // ),
              child: ListView.builder(
                itemCount: model.itemList.length,
                itemBuilder: (context, index) {
                  final itemListCopy = model.itemList[index];
                  return Text(
                    itemListCopy['name'],
                    style: TextStyle(fontSize: 30),
                  );
                }
              ),
            );
          } else {
            return Center(
              child: Text('アイテムがありません'),
            );
          }
        },
      ),
    );
  }
}
