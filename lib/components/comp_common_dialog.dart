// 共通ダイアログ コンポーネント
import 'package:flutter/material.dart';
import 'package:okiben/components/comp_close_circle_button.dart';
import 'package:okiben/customs.dart';



class CompCommonDialog extends StatefulWidget {
  const CompCommonDialog({super.key,
    required this.title,
    required this.contentChildren,
    this.actionsChildren,
    this.customWidth = 350,
    this.customHeight = 180,
    this.customContentMainAxisAlignment = MainAxisAlignment.spaceBetween
  });

  final String title;
  final List<Widget> contentChildren;
  final List<Widget>? actionsChildren;
  final double customWidth;
  final double customHeight;
  final MainAxisAlignment customContentMainAxisAlignment;

  @override
  CompCommonDialogState createState() => CompCommonDialogState();
}

class CompCommonDialogState extends State<CompCommonDialog> {

  @override
  Widget build(BuildContext context) {
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
  }
}