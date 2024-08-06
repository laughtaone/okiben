import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:okiben/pages/okiben_manage/okiben_manage.dart';
import 'package:okiben/pages/view/view.dart';
import 'package:okiben/pages/setting/setting.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';



void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OkibenManageModel()),
        ChangeNotifierProvider(create: (context) => ThemeModel()),
      ],
      child: StartPageHome(),
    ),
  );
}

class StartPageHome extends StatelessWidget {
  const StartPageHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context); // ここでThemeModelを取得
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StartPageWidget(),

      // ライトモード時
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.light(
          primary: Color(0xFF0A0E21),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xfff0f0f0),
        ),
        fontFamily: 'IBM_Plex_Sans_JP',
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color(0xfff0f0f0),
        ),
      ),

      // ダークモード時
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.dark(
          primary: Color(0xFFf0f0f0),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF3a3a3a),
        ),
        fontFamily: 'IBM_Plex_Sans_JP',
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF202020),
        ),
      ),
      themeMode: themeModel.isDarkMode ? ThemeMode.dark : ThemeMode.light,
    );
  }
}

class StartPageWidget extends StatefulWidget {
  const StartPageWidget({Key? key}) : super(key: key);

  @override
  State<StartPageWidget> createState() => _StartPageWidgetState();
}


class _StartPageWidgetState extends State<StartPageWidget> {
  // const _StartPageWidgetState({Key? key}) : super(key: key);
  var _currentIndex = 0;

  var _pages = <Widget>[
    OkibenManagePage(),
    ViewPage()
  ];

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: '置き勉管理',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined),
            label: 'ビュー',
          ),
        ],
        currentIndex: _currentIndex, // 現在のインデックスを設定
        onTap: _onTap, // タップ時に呼ばれるメソッドを設定
      ),
    );
  }
}

class ThemeModel extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void setDarkMode() {
    _isDarkMode = true;
    notifyListeners();
  }

  void setLightMode() {
    _isDarkMode = false;
    notifyListeners();
  }
}