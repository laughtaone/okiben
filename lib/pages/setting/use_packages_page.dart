import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:okiben/components/comp_common_appbar.dart';
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
      body: Theme(
        data: ThemeData.dark(),
        child: SettingsList(
          platform: DevicePlatform.iOS,
          sections: [
            // --------------------- 使用パッケージ・バージョン ---------------------
            SettingsSection(
              title: const Text(
                '使用パッケージ・バージョン',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )
              ),
              tiles: []
              // tiles: [for (var item in usePackagesData)
              //   SettingsTile.navigation(
              //     title: Text(
              //       item['name'] ?? '',
              //       style: const TextStyle(fontSize: 18)
              //     ),
              //     value: Text(
              //       item['version'] ?? '',
              //       style: const TextStyle(fontSize: 18)
              //     ),
              //     onPressed: (BuildContext context) async {
              //       await functionLaunchUrl(item['url'] ?? '');
              //     },
              //   ),
              // ],
            ),
            // ------------------------------------------------------------------
            // --------------------- 使用パッケージ・バージョン ---------------------
            // --------------------- 使用パッケージ・バージョン ---------------------
            SettingsSection(
              title: const Text(
                'ライセンス (pub.devより引用)',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )
              ),
              tiles: []
              // tiles: [for (var item in usePackagesData)
              //   SettingsTile(
              //     title: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text('[${item['name'] ?? ''}]', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              //         Text(item['licence'] ?? '', style: const TextStyle(fontSize: 13)),
              //       ],
              //     ),
              //   ),
              // ],
            )
            // ------------------------------------------------------------------
          ],
        ),
      )
    );
  }
}
