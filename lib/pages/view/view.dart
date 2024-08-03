// ビュー画面
// flutter run -d chrome lib/pages/okiben_manage/okiben_manage.dart

import 'package:flutter/material.dart';
import 'package:okiben/customs.dart';
import 'package:flutter/cupertino.dart';
import 'package:okiben/pages/view/view.dart';
import 'package:okiben/pages/view/caution.dart';

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
      body: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18, top: 10),
        child: Center(
          child: Column(
            children: [
              CautionWidget(cautionText:'持ち物がどこにあるか一目でわかります', backColor:Colors.black12, textSize:15.0, cautionIcon: Icons.check),
            ],
          ),
        ),
      ),
    );
  }
}
