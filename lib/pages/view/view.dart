// ビュー画面
import 'package:flutter/material.dart';
import 'package:okiben/components/comp_common_appbar.dart';
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
                    ? Text(
                        '登録されている持ち物は0個です',
                        style: TextStyle(fontSize: 18),
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
