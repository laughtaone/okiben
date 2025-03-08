import 'package:flutter/material.dart';
import 'package:okiben/pages/setting/setting.dart';



class CompCommonAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CompCommonAppbar({super.key,
    required this.icon,
    required this.title,
    this.isCloseButton=false,
  });

  final IconData icon;
  final String title;
  final bool isCloseButton;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: (Theme.of(context).brightness == Brightness.light)
              ? Colors.black
              : Colors.white
          ),
          SizedBox(width: 5),
          Text(title),
        ],
      ),
      automaticallyImplyLeading: false, // 左側の閉じるボタン非表示
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor, // Themeから色を取得
      actions: [
        IconButton(
          icon: Icon(
            (isCloseButton) ? Icons.close : Icons.settings,
            color: Theme.of(context).brightness == Brightness.light
              ? Colors.black87
              : Colors.white,
            size: 26,
          ),
          onPressed: () {
            if (isCloseButton) {
              Navigator.pop(context);
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingPage(),
                  fullscreenDialog: true,
                ),
              );
            }
          }
        )
      ],
    );
  }
}