// ビュー画面
import 'package:flutter/material.dart';
import 'package:okiben/components/comp_common_appbar.dart';
import 'package:okiben/components/comp_fake_add_button.dart';
import 'package:okiben/pages/okiben_manage/okiben_manage.dart';
import 'package:okiben/components/view/comp_view_info.dart';
import 'package:okiben/components/view/comp_view_tile.dart';
import 'package:provider/provider.dart';




class ViewPage extends StatefulWidget {
  const ViewPage({super.key});

  @override
  ViewPageState createState() => ViewPageState();
}

class ViewPageState extends State<ViewPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CompCommonAppbar(
        icon: Icons.location_on_outlined,
        title: 'ビュー'
      ),
      body: Consumer<OkibenManageModel>(
        builder: (context, model, child) {
          return Padding(
            padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Column(
              children: [
                CompViewInfo(),
                Expanded(
                  child: model.itemList.isEmpty
                    ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('🫥', style: TextStyle(fontSize: 60)),
                          Text('アイテムがありません', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
                          SizedBox(height: 30),
                          Wrap(
                            alignment :WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                            Text('「置き勉管理」タブの', style: TextStyle(fontSize: 15)),
                            CompFakeAddButton(sizeOneSide: 36, customBorderRadius: 10, customHorizontalMargin: 6),
                            Text('ボタンを押して'),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text('アイテムを追加してください', style: TextStyle(fontSize: 15)),
                            )
                          ])
                        ],
                      ),
                    )
                    : Column(
                      children: [
                        // --------------------- 学校にあるもの　--------------------
                        Expanded(
                          child: CompViewTile(
                            isInSchool: true,
                            itemList: model.itemList
                          ),
                        ),
                        // -------------------------------------------------------

                        SizedBox(height: 5),

                        // ---------------------- 家にあるもの　--------------------
                        Expanded(
                          child: CompViewTile(
                            isInSchool: false,
                            itemList: model.itemList
                          ),
                        ),
                        // -------------------------------------------------------
                        SizedBox(height: 5),
                      ],
                    )
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
