// 設定画面
// flutter run -d chrome lib/pages/setting/setting.dart

import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

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
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        ),
        body: SettingsList(
          platform: DevicePlatform.iOS,
          sections: [
            SettingsSection(
              title: const Text('画面モード'),
              tiles: <SettingsTile>[
                SettingsTile.switchTile(
                  leading: Icon(Icons.dark_mode_outlined),
                  title: const Text('ダークモードにする'),
                  description: const Text(
                    'この設定が"オフ"でライトモード、"オン"でダークモードになります。',
                    style: TextStyle(fontSize: 12),
                  ),
                  initialValue: true,
                  onToggle: (value) {},
                )
              ],
            ),
            SettingsSection(
              title: const Text('このアプリの使い方'),
              tiles: <SettingsTile>[
                SettingsTile(
                  leading: Icon(Icons.looks_one_outlined),
                  title: const Text('管理したいアイテムを「置き勉管理」タブに追加する'),
                ),
                SettingsTile(
                  leading: Icon(Icons.looks_two_outlined),
                  title: const Text(
                      '追加したアイテムを置き勉したらスイッチをオンに、置き勉していなかったらスイッチをオフにする'),
                ),
                SettingsTile(
                  leading: Icon(Icons.looks_3_outlined),
                  title: RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(text: '各アイテムについて、アイテムをタップ後、\n'),
                        TextSpan(text: '・名前を編集するには「編集」ボタン\n'),
                        TextSpan(text: '・メモを追加するには「メモ」ボタン\n'),
                        TextSpan(text: '・削除するには「削除」ボタン\n'),
                        TextSpan(text: 'を押す'),
                      ],
                    ),
                  ),
                ),
                SettingsTile(
                  leading: Icon(Icons.looks_4_outlined),
                  title: const Text('各アイテムの"置き勉状況"を一覧で見たい時は「ビュー」タブから見る'),
                ),
              ],
            ),
            SettingsSection(
              title: const Text('Danger Zone (!操作に要注意!)'),
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  leading: Icon(Icons.delete_sweep_outlined), // ← 追加
                  title: const Text('登録中のアイテムを一括削除'),
                  trailing: const Icon(Icons.chevron_right_outlined), // ← 追加
                  onPressed: null,
                ),
              ],
            ),
          ],
        ));
  }
}
