// 置き勉管理画面
// flutter run -d chrome lib/pages/okiben_manage.dart

import 'package:flutter/material.dart';
import 'package:okiben/main.dart';


void main() {
  runApp(
    OkibenManagePageHome()
  );
}

class OkibenManagePageHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OkibenManagePage(),
    );
  }
}

class OkibenManagePage extends StatelessWidget {
  const OkibenManagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('置き勉管理'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () => {},
              icon: const Icon(Icons.create_new_folder)
            ),
            TextButton(
              child: Text('編集'),
              onPressed: () => {},
            )
          ],
        ),
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