import 'package:flutter/material.dart';
import 'home.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';


void main() {
  runApp(
    StartPageHome()
  );
}

class StartPageHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StartPage(),
    );
  }
}

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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