import 'package:flutter/material.dart';
import 'package:okiben/functions/func_theme.dart';
import 'package:okiben/pages/okiben_manage/okiben_manage.dart';
import 'package:okiben/pages/view/view.dart';
import 'package:provider/provider.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String? themeMode = await funcLoadTheme(); // funcLoadThemeを呼び出してテーマモードを取得

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OkibenManageModel()),
        ChangeNotifierProvider(create: (context) => ThemeModel(themeMode)),
      ],
      child: StartPageHome(),
    ),
  );
}

class StartPageHome extends StatelessWidget {
  const StartPageHome({super.key});

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
      themeMode: themeModel.themeMode,
    );
  }
}

class StartPageWidget extends StatefulWidget {
  const StartPageWidget({super.key});

  @override
  State<StartPageWidget> createState() => _StartPageWidgetState();
}


class _StartPageWidgetState extends State<StartPageWidget> {
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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.tune_outlined),
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
  late ThemeMode _themeMode;

  ThemeModel(String? themeMode) {
    if (themeMode == 'dark') {
      _themeMode = ThemeMode.dark;
    } else if (themeMode == 'light') {
      _themeMode = ThemeMode.light;
    } else {
      _themeMode = ThemeMode.system;
    }
  }

  ThemeMode get themeMode => _themeMode;

  void setDarkMode() {
    _themeMode = ThemeMode.dark;
    notifyListeners();
  }

  void setLightMode() {
    _themeMode = ThemeMode.light;
    notifyListeners();
  }

  void setSystemMode() {
    _themeMode = ThemeMode.system;
    notifyListeners();
  }
}