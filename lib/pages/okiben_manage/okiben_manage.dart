// 置き勉管理画面
// flutter run -d chrome lib/pages/okiben_manage/okiben_manage.dart

import 'package:flutter/material.dart';
import 'package:okiben/customs.dart';
import 'package:okiben/pages/okiben_manage/item_tile.dart';

void main() {
  runApp(OkibenManagePageHome());
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
                onPressed: () => {}, icon: const Icon(Icons.create_new_folder)),
            TextButton(
              child: Text('編集'),
              onPressed: () => {},
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
            child: Center(
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  OkibenItemTile(image: 'assets/images/bread.png', title: '数学の教科書', value: false),
                  OkibenItemTile(image: 'assets/images/big_image_sample.png', title: '国語の教科書', value: false),
                  // OkibenItemTile(image: '', title: '科学の教科書', value: false),
                  // OkibenItemTile(image: '', title: '生物の教科書', value: false),
                  // OkibenItemTile(image: '', title: '公民の教科書', value: false),
                ],
              ),
            ),
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
