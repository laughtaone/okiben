import 'package:flutter/material.dart';
import 'package:okiben/components/comp_common_appbar.dart';
import 'package:okiben/functions/func_open_url.dart';
import 'package:okiben/pages/setting/use_packages/use_packages_data.dart';
import 'package:settings_ui/settings_ui.dart';



class UsePackagesPage extends StatefulWidget {
  const UsePackagesPage({super.key});

  @override
  UsePackagesPageState createState() => UsePackagesPageState();
}



class UsePackagesPageState extends State<UsePackagesPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CompCommonAppbar(
        icon: Icons.book_outlined,
        title: '使用パッケージ',
        isCloseButton: true,
        isDisplayBackButton: true,
        isDisplayRightButton: false
      ),
      body: SettingsList(
        platform: DevicePlatform.iOS,
        sections: [
          // --------------------- 使用パッケージ・バージョン ---------------------
          SettingsSection(
            title: const Text(
              '使用パッケージ・バージョン',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)
            ),
            tiles: [for (var item in usePackagesData)
              SettingsTile.navigation(
                title: Text(
                  item['name'] ?? '',
                  style: const TextStyle(fontSize: 18)
                ),
                value: Text(
                  item['version'] ?? '',
                  style: const TextStyle(fontSize: 18)
                ),
                onPressed: (BuildContext context) async {
                  await funcOpenUrl(item['url'] ?? '');
                },
              ),
            ],
          ),
          // ------------------------------------------------------------------
          // ---------------------------- ライセンス ---------------------------
          SettingsSection(
            title: const Text(
              'ライセンス (pub.devより引用)',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)
            ),
            tiles: [for (var item in usePackagesData)
              SettingsTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('[${item['name'] ?? ''}]', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    Text(item['licence'] ?? '', style: TextStyle(fontSize: 13)),
                  ],
                ),
              ),
            ],
          )
          // ------------------------------------------------------------------
        ],
      ),
    );
  }
}
