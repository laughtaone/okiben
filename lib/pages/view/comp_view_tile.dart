// ビュー画面 - 持ち物リストのタイル
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:okiben/customs.dart';



class CompViewTile extends StatefulWidget {
  const CompViewTile({super.key,
    required this.isInSchool,
    required this.itemList
  });

  final bool isInSchool;
  final List<Map<String, dynamic>> itemList;

  @override
  CompViewTileState createState() => CompViewTileState();
}

class CompViewTileState extends State<CompViewTile> {
  int itemListCount = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      itemListCount = widget.itemList
      .where((element) =>
          element['isOkiben'] == widget.isInSchool)
      .length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          Transform.scale(
            scale: 0.8,
            child: CupertinoSwitch(
              value: widget.isInSchool,
              onChanged: (_) {},
              activeTrackColor: Color(0xff64c466),
            ),
          ),
          Text(
            '${(widget.isInSchool ? '学校' : '家')}にあるもの',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )
        ]),
        SizedBox(height: 2),
        Expanded(
          child: itemListCount == 0
              ? Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text('該当する持ち物はありません'),
              )
              : Container(
                padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black38,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : Color(0xff444444),
                ),
                child: Scrollbar(
                  thumbVisibility: true,
                  thickness: viewScrollBarThicknessSize(),
                  child: ListView.builder(
                    controller: ScrollController(),
                    itemCount: widget.itemList.length,
                    itemBuilder: (context, index) {
                      final itemListCopy = widget.itemList[index];
                      if (itemListCopy['isOkiben'] == widget.isInSchool) {
                      return Text(
                        itemListCopy['name'] ?? '名前なし',
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : Colors.white,
                        ),
                      );
                      } else {
                        return SizedBox.shrink();// この条件分岐に到達することはあり得ないけどnull safetyのために書く
                      }
                    },
                    ),
                ),
              ),
            ),
]
    );
  }
}