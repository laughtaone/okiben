// 置き勉管理画面
// flutter run -d chrome lib/pages/okiben_manage/okiben_manage.dart

import 'package:flutter/material.dart';
import 'package:okiben/customs.dart';
import 'package:flutter/cupertino.dart';
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

class OkibenManagePage extends StatefulWidget {
  @override
  _OkibenManagePageState createState() => _OkibenManagePageState();
}

class _OkibenManagePageState extends State<OkibenManagePage> {
  List<Map<String, dynamic>> itemList = [
    {
      'name': 'OSの教科書',
      'isOkiben': true,
      'imagePath': 'assets/images/bread.png'
    },
    {
      'name': '確率の教科書',
      'isOkiben': false,
      'imagePath': 'assets/images/big_image_sample.png'
    },
  ];

  var _editItemText = '';
  var _finalItemText = '';

  void _toggleSwitch(int index, bool newValue) {
    setState(() {
      itemList[index]['isOkiben'] = newValue;
    });
  }

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
        body: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
          child: ListView.builder(
              itemCount: itemList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    OkibenItemTile(
                      image: 'assets/images/bread.png',
                      title: itemList[index]['name'],
                      value: itemList[index]['isOkiben'],
                      onChanged: (newValue) => _toggleSwitch(index, newValue)
                    ),
                  ],
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('新しいアイテムを追加'),
                  content: TextField(
                    // controller: controller,
                    decoration: InputDecoration(labelText: 'アイテムの名前を入力'),
                    onChanged: (value) {
                      setState(() {
                        _editItemText = value;
                        print('_editItemTextは$_editItemText');
                      });
                    },
                  ),
                  actions: [
                    TextButton(
                      child: Text('キャンセル'),
                      onPressed: () {
                        Navigator.pop(context); //画面を閉じる
                      },
                    ),
                    TextButton(
                      child: Text('追加'),
                      onPressed: () {
                        setState(() {
                          _finalItemText = _editItemText; //編集用を保存用に
                        });
                        itemList.add({
                          'name': _finalItemText,
                          'isOkiben': false,
                          'imagePath': ''
                        });
                        print(itemList);
                        Navigator.pop(context);
                        print('_finalItemTextは$_finalItemText');
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: Icon(Icons.add),
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
