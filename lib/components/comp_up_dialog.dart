// 下から出てきて途中の位置で止まるダイアログ コンポーネント
import 'package:flutter/material.dart';
import 'package:okiben/components/comp_close_circle_button.dart';
import 'package:okiben/customs.dart';



class CompUpDialog extends StatefulWidget {
  const CompUpDialog({super.key,
    required this.title,
    required this.contentChildren
  });

  final String title;
  final List<Widget> contentChildren;

  @override
  CompUpDialogState createState() => CompUpDialogState();
}

class CompUpDialogState extends State<CompUpDialog> {

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.4, // 最初の表示サイズ（40%）
      minChildSize: 0.2, // 最小サイズ（20%）
      maxChildSize: 0.8, // 最大サイズ（80%）
      expand: false, // falseにすることで、元の画面が操作可能
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            controller: scrollController,
            children: const [
              Text(
                "ここにコンテンツを追加",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text("スワイプするとサイズが変わる"),
            ],
          ),
        );
      },
    );
  }

  void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // これをtrueにしないとサイズ調整が難しい
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return build(context);
      }
    );
  }


    /*
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.title),
          CompCloseCircleButton(onPressed: () => Navigator.pop(context))
        ],
      ),
      backgroundColor: Theme.of(context).brightness == Brightness.light
        ? Colors.white
        : dialogBackColorDeep(),
      content: SizedBox(
        width: widget.customWidth,
        height: widget.customHeight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: widget.customContentMainAxisAlignment,
          children: widget.contentChildren
        ),
      ),
      actions: widget.actionsChildren
    );
    */
}