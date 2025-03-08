// 置き勉管理画面
import 'package:flutter/material.dart';
import 'package:okiben/components/comp_common_appbar.dart';
import 'package:okiben/components/comp_common_button.dart';
import 'package:okiben/components/comp_common_dialog.dart';
import 'package:okiben/functions/func_load_item_list.dart';
import 'package:okiben/pages/okiben_manage/item_tile.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';



class OkibenManagePage extends StatefulWidget {
  const OkibenManagePage({super.key});

  @override
  OkibenManagePageState createState() => OkibenManagePageState();
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
      'memo': '来週の確率の授業で必要！',
      'isOkiben': false,
      'imagePath': 'assets/images/big_image_sample.png'
    },
  ];

  OkibenManageModel() {
    load();
  }

  List<Map<String, dynamic>> get itemList => _itemList;

  void load() async {
    _itemList = await funcLoadItemList();
    notifyListeners();
  }

  void _saveItemList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('itemList', json.encode(_itemList));
  }

  void toggleSwitch(int index, bool newValue) {
    _itemList[index]['isOkiben'] = newValue;
    _saveItemList();
    notifyListeners();
  }

  void removeItem(int index) {
    if (index >= 0 && index < _itemList.length) {
      _itemList.removeAt(index);
      _saveItemList();
      notifyListeners();
    }
  }

  void updateItemTitle(int index, String newTitle) {
    _itemList[index]['name'] = newTitle;
    _saveItemList();
    notifyListeners();
  }

  void updateItemMemo(int index, String newMemo) {
    _itemList[index]['memo'] = newMemo;
    _saveItemList();
    notifyListeners();
  }

  void addItem(String newItemName) {
    _itemList.add(
        {'name': newItemName, 'memo': '', 'isOkiben': false, 'imagePath': ''});
    _saveItemList();
    notifyListeners();
  }

  void clearItemList() {
    _itemList.clear();
    _saveItemList();
    notifyListeners();
  }
}

class OkibenManagePageState extends State<OkibenManagePage> {
  var _finalItemText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
        ? Colors.white
        : Colors.black26,
      appBar: CompCommonAppbar(
        icon: Icons.tune_outlined,
        title: '置き勉管理'
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
                    onChanged: (newValue) {
                      model.toggleSwitch(index, newValue);
                    },
                    onNameChanged: (String newName) {
                      model.updateItemTitle(index, newName); // タイトルを更新
                    },
                    onMemoChanged: (String newMemo) {
                      model.updateItemMemo(index, newMemo); // メモを更新
                    },
                    delete: (int index) {
                      model.removeItem(index);
                    },
                  ),
                ],
              );
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              String newItemName = '';
              return StatefulBuilder(
                builder: (context, setState) {
                  return CompCommonDialog(
                    title: 'アイテム追加',
                    customContentMainAxisAlignment: MainAxisAlignment.spaceAround,
                    customHeight: 225,
                    contentChildren: [
                      Column(children: [
                        SizedBox(
                          width: double.infinity,
                          child: Text('↓変更後の名前を入力', style: TextStyle(fontSize: 13), textAlign: TextAlign.left)
                        ),
                        SizedBox(height: 2),
                        TextField(
                          maxLines: null,
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            setState(() {
                              newItemName = value;
                            });
                          },
                        ),
                      ]),
                      CompCommonButton(
                        buttonText: '追加',
                        onPressed: (newItemName.isEmpty)
                          ? null
                          : () {
                            setState(() {
                              _finalItemText = newItemName; //編集用を保存用に
                            });
                            if (_finalItemText.isNotEmpty) {
                              Provider.of<OkibenManageModel>(context, listen: false)
                                // OkibenManageModel().addItem(_finalItemText);では、Providerを通じて操作してないからダメ
                                .addItem(
                                  _finalItemText
                                );
                              debugPrint('_finalItemTextは$_finalItemText');
                            }
                            Navigator.pop(context);
                          },
                        isDarkMode: Theme.of(context).brightness == Brightness.dark ? true : false,
                      )
                    ]
                  );
                }
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
