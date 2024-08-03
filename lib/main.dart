import 'package:flutter/material.dart';
import 'home.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';


void main() {
  runApp(
    StartPageHome()
  );
}

class StartPageHome extends StatelessWidget {
  const StartPageHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StartPageWidget(),
    );
  }
}

class StartPageWidget extends StatefulWidget {
  const StartPageWidget({Key? key}) : super(key: key);

  @override
  State<StartPageWidget> createState() => _StartPageWidgetState();
}


class _StartPageWidgetState extends State<StartPageWidget> {
  // const _StartPageWidgetState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        // fontFamily: 'Georgia',
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('ホーム'),),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('置き勉管理アプリ')
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.swap_horiz),
              label: '貸し借り管理',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: '置き勉管理',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.checklist),
              label: 'リマインド',
            ),
          ],
        ),
      ),
    );
  }
}