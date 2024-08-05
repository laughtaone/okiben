// 設定画面
// flutter run -d chrome lib/pages/setting/setting.dart

import 'package:flutter/material.dart';



void main() {
  runApp(SettingPageHome());
}

class SettingPageHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SettingPage(),
    );
  }
}

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.settings,
                color: Colors.black,
              ),
              SizedBox(width: 5),
              Text(
                '設定',
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
              iconSize: 29,
            )
          ],
          automaticallyImplyLeading: false, // 右上の閉じるボタン非表示
          backgroundColor:
            Theme.of(context).appBarTheme.backgroundColor,
          ),
        body: Center(
          child: Column(
            children: [
              Text('あ'),
            ],
          ),
        ),
      );
  }
}
