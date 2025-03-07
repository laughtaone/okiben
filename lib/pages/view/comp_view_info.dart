// ビュー画面 冒頭説明フィールド
import 'package:flutter/material.dart';



class CompViewInfo extends StatelessWidget {
  const CompViewInfo({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).brightness == Brightness.light
          ? Color(0xffededed)
          : Color(0xff303030),
      ),
      padding: EdgeInsets.fromLTRB(10,8,8,8),
      margin: EdgeInsets.only(left: 0, right: 0, top: 8, bottom: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 0),
                child: Icon(
                  Icons.check,
                  size: 20,
                  color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    '持ち物がどこにあるか一目でわかります',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 0),
                child: Icon(
                  Icons.check,
                  size: 20,
                  color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'スクロール可能です',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}