// 設定画面
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:okiben/components/comp_common_appbar.dart';
import 'package:okiben/functions/func_theme.dart';
import 'package:okiben/pages/setting/theme_setting_page.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:provider/provider.dart';
import 'package:okiben/pages/okiben_manage/okiben_manage.dart';
import 'package:okiben/customs.dart';
import 'package:okiben/main.dart';



class SettingPage extends StatefulWidget {
  const SettingPage({super.key});
  @override
  SettingPageState createState() => SettingPageState();
}

class SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    final String? themeSetting = Provider.of<ThemeModel>(context).themeMode.toString().split('.').last;

    return Scaffold(
      appBar: CompCommonAppbar(
        icon: Icons.settings,
        title: '設定',
        isCloseButton: true
      ),
      body: SettingsList(
        platform: DevicePlatform.iOS,
        sections: [
          SettingsSection(
            title: Text(
              '外観モード',
              style: Theme.of(context).brightness == Brightness.light
                ? settingSectionTitleLight()
                : settingSectionTitleDark(),
            ),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: Icon(Icons.light_mode_outlined),
                title: const Text('外観モード'),
                value: Text(
                  themeSetting == 'system'
                    ? '端末に合わせる'
                    : themeSetting == 'light'
                      ? 'ライトモード'
                      : 'ダークモード',
                ),
                description: Text(
                  '画面全体の配色をカスタマイズできます。',
                  style: Theme.of(context).brightness == Brightness.light
                    ? settingDescriptionLight()
                    : settingDescriptionDark(),
                ),
                onPressed: (_) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return ThemeSettingPage();
                      },
                    ),
                  );
                }
              ),
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
                title: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text('アイテムを「置き勉管理」タブの右下の'),
                    Container(
                      width: 20,
                      height: 20,
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        color: addIconButtonColor(isDarkMode:  Theme.of(context).brightness == Brightness.dark),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(child: Icon(
                        Icons.add_outlined,
                        size: 18,
                        color: (Theme.of(context).brightness == Brightness.light) ? Colors.white : Colors.black
                      ))
                    ),
                    Text('ボタンから追加します')
                  ],
                )
              ),
              SettingsTile(
                leading: Icon(Icons.looks_two_outlined),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('追加したアイテムを'),
                    SizedBox(height: 5),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      SizedBox(width: 170, child: Center(child: Text('置き勉したら'))),
                      Transform.scale(
                        scale: 0.8,
                        child: CupertinoSwitch(
                          value: true,
                          onChanged: (_) {},
                          activeTrackColor: Color(0xff64c466),
                        ),
                      )
                    ]),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      SizedBox(width: 170, child: Center(child: Text('置き勉しなかったら'))),
                      Transform.scale(
                        scale: 0.8,
                        child: CupertinoSwitch(
                          value: false,
                          onChanged: (_) {},
                          activeTrackColor: Color(0xff64c466),
                        ),
                      )
                    ]),
                    SizedBox(height: 5),
                    const Text('にします')
                  ],
                ),
              ),
              SettingsTile(
                leading: Icon(Icons.looks_3_outlined),
                title: const Text('各アイテムをタップすると「編集」「メモ」「削除」の操作ができます')
              ),
              SettingsTile(
                leading: Icon(Icons.looks_4_outlined),
                title: const Text('各アイテムの置き勉状況は「ビュー」タブから一覧で見ることができます')
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
      )
    );
  }
}
