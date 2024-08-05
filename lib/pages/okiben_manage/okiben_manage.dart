// 置き勉管理画面
// flutter run -d chrome lib/pages/okiben_manage/okiben_manage.dart

import 'package:flutter/material.dart';
import 'package:okiben/customs.dart';
import 'package:flutter/cupertino.dart';
import 'package:okiben/pages/okiben_manage/item_tile.dart';
import 'package:okiben/pages/view/view.dart';
import 'package:okiben/pages/view/caution.dart';
import 'package:provider/provider.dart';

// void main() {
//   runApp(OkibenManagePageHome());
// }

// class OkibenManagePageHome extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: OkibenManagePage(),
//     );
//   }
// }

class OkibenManagePage extends StatefulWidget {
  @override
  _OkibenManagePageState createState() => _OkibenManagePageState();
}

class OkibenManageModel extends ChangeNotifier {
  List<Map<String, dynamic>> _itemList = [
    {
      'name': 'OSの教科書',
      'memo': 'Aくんに貸した',
      'isOkiben': true,
      'imagePath': 'assets/images/bread.png'
    },
    {
      'name': '確率の教科書',
      'memo': '来週の確率の授業で必要！来週の確率の授業で必要！来週の確率の授業で必要！',
      'isOkiben': false,
      'imagePath': 'assets/images/big_image_sample.png'
    },
  ];

  List<Map<String, dynamic>> get itemList => _itemList;


  void toggleSwitch(int index, bool newValue) {
    _itemList[index]['isOkiben'] = newValue;
    notifyListeners();
    print(_itemList);
  }
  void removeItem(int index) {
    if (index >= 0 && index < _itemList.length) {
      _itemList.removeAt(index);
      notifyListeners();
    }
  }
  void updateItemTitle(int index, String newTitle) {
    _itemList[index]['name'] = newTitle;
    notifyListeners();
    print(_itemList);
  }
  void updateItemMemo(int index, String newMemo) {
    _itemList[index]['memo'] = newMemo;
    notifyListeners();
    print(_itemList);
  }
  void addItem(String newItemName) {
    _itemList.add({
      'name': newItemName,
      'memo': '',
      'isOkiben': false,
      'imagePath': ''
    });
    notifyListeners();
    print(_itemList);
  }
}

class _OkibenManagePageState extends State<OkibenManagePage> {
  var _editItemText = '';
  var _finalItemText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_bag,
              color: Colors.black,
            ),
            SizedBox(width: 5),
            Text(
              '置き勉管理',
            ),
          ],
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor, // Themeから色を取得
        actions: [],
      ),
      body: Consumer<OkibenManageModel>(builder: (context, model, child) {
        return Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: ListView.builder(
            itemCount: model.itemList.length,
            itemBuilder: (context, index) {
              final itemListCopy = model.itemList[index];
              return Column(
                children: [
                  OkibenItemTile(
                    image: 'assets/images/bread.png',
                    title: itemListCopy['name'],
                    value: itemListCopy['isOkiben'],
                    memo: itemListCopy['memo'],
                    indexNum: index,
                    onChanged: (newValue) => model.toggleSwitch(index, newValue),
                    onNameChanged: (String newName) {
                      model.updateItemTitle(index, newName); // タイトルを更新
                    },
                    onMemoChanged: (String newMemo) {
                      model.updateItemMemo(index, newMemo); // メモを更新
                    },
                    delete: (int index) {
                      model.removeItem(index);
                    }
                  ),
                ],
              );
            }
          ),
        );
      }),
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
                      Provider.of<OkibenManageModel>(context, listen: false).addItem(_finalItemText);  // OkibenManageModel().addItem(_finalItemText);では、Providerを通じて操作してないからダメ
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
    );
  }
}
