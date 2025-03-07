
import 'package:flutter/material.dart';
import 'package:okiben/customs.dart';



class CompOperationTile extends StatefulWidget {
  const CompOperationTile({super.key,
    required this.buttonText,
    required this.icon,
    required this.onPressed
  });

  final String buttonText;
  final IconData icon;
  final void Function() onPressed;

  @override
  CompOperationTileState createState() => CompOperationTileState();
}

class CompOperationTileState extends State<CompOperationTile> {

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
      style: TextButton.styleFrom(
        backgroundColor: itemTileOperateEditButtonColor(),
        fixedSize: itemTileOperateButtonSize(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            widget.icon,
            size: 31,
            color: Colors.black87,
          ),
          SizedBox(height: 13),
          Text(
            widget.buttonText,
            style: TextStyle(
              fontSize: 19,
              color: Colors.black87,
            )
          )
        ],
      ),
    );
  }
}