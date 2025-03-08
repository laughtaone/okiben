// 設定画面
// flutter run -d chrome lib/pages/setting/setting.dart

import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:provider/provider.dart';
import 'package:okiben/pages/okiben_manage/okiben_manage.dart';
import 'package:okiben/main.dart';
import 'package:okiben/customs.dart';



class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  SettingPageState createState() => SettingPageState();
}

class SettingPageState extends State<SettingPage> {
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
                color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black87
                  : Colors.white,
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
              title: Text(
                '画面モード',
                style: Theme.of(context).brightness == Brightness.light
                  ? settingSectionTitleLight()
                  : settingSectionTitleDark(),
              ),
              tiles: <SettingsTile>[
                SettingsTile.switchTile(
                  leading: Icon(Icons.dark_mode_outlined),
                  title: const Text('ダークモードにする'),
                  description: Text(
                    'この設定が"オフ"でライトモード、"オン"でダークモードになります。',
                    style: Theme.of(context).brightness == Brightness.light
                      ? settingDescriptionLight()
                      : settingDescriptionDark(),
                  ),
                  initialValue: Provider.of<ThemeModel>(context).isDarkMode,
                  onToggle: (value) {
                    if (value) {
                      // ダークモードに切り替え
                      Provider.of<ThemeModel>(context, listen: false).setDarkMode();
                    } else {
                      // ライトモードに切り替え
                      Provider.of<ThemeModel>(context, listen: false).setLightMode();
                    }
                  },
                )
              ],
            ),
            SettingsSection(
              title: Text(
                'このアプリの使い方',
                style: Theme.of(context).brightness == Brightness.light
                  ? settingSectionTitleLight()
                  : settingSectionTitleDark(),
              ),
              tiles: <SettingsTile>[
                SettingsTile(
                  leading: Icon(Icons.looks_one_outlined),
                  title: const Text('管理したいアイテムを「置き勉管理」タブの右下の＋ボタンから追加する'),
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
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white,
                      ),
                      children: const <TextSpan>[
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
              title: Text(
                'Danger Zone (!操作に要注意!)',
                style: Theme.of(context).brightness == Brightness.light
                  ? settingSectionTitleLight()
                  : settingSectionTitleDark(),
              ),
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  leading: Icon(Icons.delete_sweep_outlined),
                  title: const Text('登録中のアイテムを一括削除'),
                  description: Text(
                    'この操作を実行すると、登録されている全てのアイテムが一括削除されます。',
                    style: Theme.of(context).brightness == Brightness.light
                      ? settingDescriptionLight()
                      : settingDescriptionDark(),
                  ),
                  onPressed: (context) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Theme.of(context).brightness == Brightness.light
                            ? Colors.white
                            : dialogBackColor(),
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.error_outlined,
                                size: 25,
                                color: Colors.red,
                              ),
                              SizedBox(width: 10),
                              Text(
                                '確認',
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                              ),
                            ],
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text.rich(
                                TextSpan(children: [
                                  TextSpan(text: 'この操作を実行すると、登録されているアイテムが'),
                                  TextSpan(text: '全て完全に削除',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red, decoration: TextDecoration.underline,decorationColor: Colors.red,)),
                                  TextSpan(text: 'されます。'),
                                ],style: TextStyle(fontSize: 16),
                              )),
                              Text.rich(
                                TextSpan(children: [
                                  TextSpan(text: 'また、実行後の'),
                                  TextSpan(text: '取り消しは完全にできません',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red, decoration: TextDecoration.underline,decorationColor: Colors.red,)),
                                  TextSpan(text: '。'),
                                ],style: TextStyle(fontSize: 16),
                              )),
                              SizedBox(height: 20),
                              Text('本当に削除しますか？', style: TextStyle(fontSize: 16),),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                // 一括削除の処理をここに記述
                                Provider.of<OkibenManageModel>(context, listen: false).clearItemList();
                                Navigator.of(context).pop();
                              },
                              child: Text('削除'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'キャンセル',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ));
  }
}
