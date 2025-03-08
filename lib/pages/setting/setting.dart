// 設定画面
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:okiben/components/comp_common_appbar.dart';
import 'package:okiben/components/comp_common_button.dart';
import 'package:okiben/components/comp_common_dialog.dart';
import 'package:okiben/functions/func_open_url.dart';
import 'package:okiben/pages/setting/theme_setting_page.dart';
import 'package:okiben/pages/setting/use_packages_page.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:provider/provider.dart';
import 'package:okiben/pages/okiben_manage/okiben_manage.dart';
import 'package:okiben/customs.dart';
import 'package:okiben/main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class SettingPage extends StatefulWidget {
  const SettingPage({super.key});
  @override
  SettingPageState createState() => SettingPageState();
}

class SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    final String themeSetting = Provider.of<ThemeModel>(context).themeMode.toString().split('.').last;

    return Scaffold(
      appBar: CompCommonAppbar(
        icon: Icons.settings,
        title: '設定',
        isCloseButton: true
      ),
      body: SettingsList(
        platform: DevicePlatform.iOS,
        sections: [
          // ---------------------------- 外観モード ------------------------------
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
          // --------------------------------------------------------------------
          // ------------------------- このアプリの使い方 --------------------------
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
          // --------------------------------------------------------------------
          // --------------------------- Danger Zone ----------------------------
          SettingsSection(
            title: Text(
              'Danger Zone (!操作に要注意!)',
              style: Theme.of(context).brightness == Brightness.light
                ? settingSectionTitleLight()
                : settingSectionTitleDark(),
            ),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: Icon(
                  Icons.delete_sweep_outlined,
                  color: Colors.red
                ),
                title: const Text(
                  '登録中のアイテムを一括削除',
                  style: TextStyle(color: Colors.red),
                ),
                description: Column(
                  children: [
                    Text(
                      'この操作を実行すると、登録されている全てのアイテムが一括削除されます。',
                      style: Theme.of(context).brightness == Brightness.light
                        ? settingDescriptionLight()
                        : settingDescriptionDark(),
                    )
                  ],
                ),
                onPressed: (context) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      bool isUnlocked = false;                      return StatefulBuilder(
                        builder: (context, setState) {
                          return CompCommonDialog(
                            customHeight: 300,
                            title: '確認',
                            contentChildren: [
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                decoration: BoxDecoration(
                                  color: Color(0xffffedf0),
                                  borderRadius: BorderRadius.circular(15)
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    SizedBox(height: 2),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        Icon(Icons.error_outlined, size: 23, color: Colors.red),
                                        SizedBox(width: 5),
                                        Padding(
                                          padding: EdgeInsets.only(top: 4),
                                          child: Text(
                                            '警告',
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Text.rich(
                                      TextSpan(children: const [
                                        TextSpan(text: '全て完全に削除',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red, decoration: TextDecoration.underline,decorationColor: Colors.red,)),
                                        TextSpan(text: 'されます'),
                                      ],style: TextStyle(
                                        fontSize: 16,
                                        color: (Theme.of(context).brightness == Brightness.light) ? Colors.white : Colors.black
                                      )
                                    )),
                                    Text.rich(
                                      TextSpan(children: const [
                                        TextSpan(text: '実行後の'),
                                        TextSpan(text: '取り消しはできません',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red, decoration: TextDecoration.underline,decorationColor: Colors.red,)),
                                      ],style: TextStyle(
                                        fontSize: 16,
                                        color: (Theme.of(context).brightness == Brightness.light) ? Colors.white : Colors.black
                                      )
                                    )),
                                  ],
                                ),
                              ),

                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text('本当に削除しますか？', style: TextStyle(fontSize: 18)),
                                    CompCommonButton(
                                      buttonText: '完全に削除',
                                      onPressed: (isUnlocked)
                                        ? () {
                                          // 一括削除の処理をここに記述
                                          Provider.of<OkibenManageModel>(context, listen: false).clearItemList();
                                          Navigator.of(context).pop();
                                        }
                                        : null,
                                      isDarkMode: Theme.of(context).brightness == Brightness.dark,
                                      customButtonColor: (Theme.of(context).brightness == Brightness.light) ? Color(0xffcc3d3d) : Color(0xffcc3d3d),
                                      customWidth: 200,
                                    )
                                  ]
                                ),
                              ),

                              TextButton(
                                onPressed: (isUnlocked)
                                  ? null
                                  : () {},
                                onLongPress: (isUnlocked)
                                  ? null
                                  : () {
                                    setState(() {
                                    isUnlocked = true;
                                    });
                                  },
                                style: TextButton.styleFrom(
                                  backgroundColor: (Theme.of(context).brightness == Brightness.light)
                                    ? Color(0xffE0E0E0)
                                    : Color(0xff666666),
                                  disabledBackgroundColor: (Theme.of(context).brightness == Brightness.light)
                                    ? Color(0xffF7F7F7)
                                    : Color(0xff464646),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                  )
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.lock_outline),
                                    SizedBox(width: 5),
                                    Padding(
                                      padding: EdgeInsets.only(top: 4),
                                      child: Text('ロック解除 (長押し)'),
                                    ),
                                  ],
                                )
                              )
                            ],
                          );
                        }
                      );
                    },
                  );
                },
              ),
            ],
          ),
          // --------------------------------------------------------------------
          // --------------------------- 開発者について ----------------------------
          SettingsSection(
            title: Text(
                '開発者について',
              style: Theme.of(context).brightness == Brightness.light
                ? settingSectionTitleLight()
                : settingSectionTitleDark(),
            ),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const FaIcon(FontAwesomeIcons.github),
                title: const Text('GitHub'),
                value: const Text('@laughtaone'),
                onPressed: (BuildContext context) async {
                  await funcOpenUrl('https://www.github.com/laughtaone/');
                },
              ),
              SettingsTile.navigation(
                leading: const FaIcon(FontAwesomeIcons.xTwitter),
                title: const Text('X'),
                value: const Text('@laughtaone'),
                onPressed: (BuildContext context) async {
                  await funcOpenUrl('https://x.com/laughtaone/');
                },
              ),
              SettingsTile.navigation(
                leading: const FaIcon(FontAwesomeIcons.appStoreIos),
                title: const Text('開発者 その他アプリ'),
                onPressed: (BuildContext context) async {
                  await funcOpenUrl('https://apps.apple.com/us/developer/taichi-usuba/id1798659459');
                },
              ),
            ],
          ),
          // --------------------------------------------------------------------
          // --------------------------- アプリについて ----------------------------
          SettingsSection(
            title: Text(
              'アプリについて',
              style: Theme.of(context).brightness == Brightness.light
                ? settingSectionTitleLight()
                : settingSectionTitleDark(),
            ),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.description_outlined),
                title: const Text('利用規約'),
                onPressed: (BuildContext context) async {
                  await funcOpenUrl('https://laughtaone.notion.site/okiben-1b0b5b93908181ff9708cf490a5226ed?pvs=4');
                },
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.description_outlined),
                title: const Text('プライバシーポリシー'),
                onPressed: (BuildContext context) async {
                  await funcOpenUrl('https://laughtaone.notion.site/okiben-1b0b5b93908181f983eaff351ba2d06b?pvs=4');
                },
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.book_outlined),
                title: const Text('使用パッケージ'),
                onPressed: (BuildContext context)  {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => UsePackagesPage()
                  ));
                },
              ),
            ],
          ),
          // --------------------------------------------------------------------
          // -------------------------- アプリバージョン ---------------------------
            SettingsSection(
              title: Text(
                'アプリバージョン',
                style: Theme.of(context).brightness == Brightness.light
                  ? settingSectionTitleLight()
                  : settingSectionTitleDark(),
              ),
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  leading: const Icon(Icons.tag_outlined),
                  title: const Text('アプリバージョン'),
                  value: const Text('1.0'),
                  onPressed: (BuildContext context) async {
                    await funcOpenUrl('https://laughtaone.notion.site/okiben-1b0b5b93908181d0b8e7e7d71066e384?pvs=4');
                  },
                ),
              ],
            ),
            // --------------------------------------------------------------------
        ],
      )
    );
  }
}
