// 下から出てくるダイアログのコンポーネント
import 'package:flutter/material.dart';
import 'package:okiben/components/comp_close_circle_button.dart';
import 'package:okiben/components/comp_dialog_bar.dart';


class CompUpDialog extends StatelessWidget {
  const CompUpDialog({
    super.key,
    required this.keyboardHeight,
    required this.initialChildSize,
    required this.minChildSize,
    required this.maxChildSize,
    required this.dialogTitle,
    required this.dialogChildren,
  });

  final double keyboardHeight;
  final double initialChildSize;
  final double minChildSize;
  final double maxChildSize;
  final String dialogTitle;
  final List<Widget> dialogChildren;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // ダイアログ外をタップしたらキーボードを閉じる
      },
      child: DraggableScrollableSheet(
        initialChildSize: initialChildSize,
        minChildSize: minChildSize,
        maxChildSize: maxChildSize,
        expand: false,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: (Theme.of(context).brightness == Brightness.light)
                ? Color(0xffffffff)
                : Color(0xff303030),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              )
            ),
            padding: EdgeInsets.fromLTRB(15, 15, 15, (keyboardHeight > 0) ? keyboardHeight + 200 : 15),
            child: Column(
              children: [
                // ------------------------- ダイアログ ヘッダー -------------------------
                CompDialogBar(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(dialogTitle, style: const TextStyle(fontSize: 22)),
                    CompCloseCircleButton(
                      customIconSize: 25,
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ),
                // --------------------------------------------------------------------
                const SizedBox(height: 15),
                // -------------------------- ダイアログ 中身 ---------------------------
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    controller: scrollController,
                    children: dialogChildren,
                  ),
                ),
                // --------------------------------------------------------------------
              ],
            ),
          );
        },
      ),
    );
  }
}
