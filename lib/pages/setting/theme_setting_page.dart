// 外観モード設定画面
import 'package:flutter/material.dart';
import 'package:okiben/components/comp_common_appbar.dart';
import 'package:okiben/functions/func_theme.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:provider/provider.dart';
import 'package:okiben/customs.dart';
import 'package:okiben/main.dart';


Icon checkIcon = Icon(Icons.check, color: Colors.blue);



class ThemeSettingPage extends StatefulWidget {
  const ThemeSettingPage({super.key});
  @override
  ThemeSettingPageState createState() => ThemeSettingPageState();
}

class ThemeSettingPageState extends State<ThemeSettingPage> {
  @override
  Widget build(BuildContext context) {
    final String themeSetting = Provider.of<ThemeModel>(context).themeMode.toString().split('.').last;

    return Scaffold(
      appBar: CompCommonAppbar(
        icon: Icons.light_mode_outlined,
        title: '外観モードの設定',
        isCloseButton: true,
        isDisplayBackButton: true,
        isDisplayRightButton: false
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
              SettingsTile(
                title: const Text('端末に合わせる'),
                value: (themeSetting == 'system')
                  ? checkIcon
                  : null,
                onPressed: (_) async {
                  final themeModel = Provider.of<ThemeModel>(context, listen: false);
                  bool isSuccessful = await funcWriteTheme('system');
                  if (isSuccessful) {
                    themeModel.setSystemMode();
                    setState(() {});
                  }
                }
              ),
              SettingsTile(
                title: const Text('ライトモード'),
                value: (themeSetting == 'light')
                  ? checkIcon
                  : null,
                onPressed: (_) async {
                  final themeModel = Provider.of<ThemeModel>(context, listen: false);
                  bool isSuccessful = await funcWriteTheme('light');
                  if (isSuccessful) {
                    themeModel.setLightMode();
                    setState(() {});
                  }
                }
              ),
              SettingsTile(
                title: const Text('ダークモード'),
                value: (themeSetting == 'dark')
                  ? checkIcon
                  : null,
                onPressed: (_) async {
                  final themeModel = Provider.of<ThemeModel>(context, listen: false);
                  bool isSuccessful = await funcWriteTheme('dark');
                  if (isSuccessful) {
                    themeModel.setDarkMode();
                    setState(() {});
                  }
                },

                // ---------------------- 末尾の説明文 ----------------------
                description: Text(
                  (themeSetting == 'system')
                    ? '端末の設定に合わせてライトモードまたはダークモードを適用します'
                    : (themeSetting == 'light')
                      ? '常にライトモードで表示します'
                      : '常にダークモードで表示します',
                ),
              ),
            ]
          ),
        ],
      )
    );
  }
}
