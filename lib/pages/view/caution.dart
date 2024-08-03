import 'package:flutter/material.dart';

class CautionWidget extends StatelessWidget {
  final String cautionText;
  final Color backColor;
  final double textSize;
  final IconData? cautionIcon;

  const CautionWidget(
      {
        Key? key,
        required this.cautionText,
        required this.backColor,
        required this.textSize,
        required this.cautionIcon
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: backColor),
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.only(left: 5, right: 5),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 2.0),
                      child: Icon(
                        cautionIcon,
                        size: 24,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          cautionText,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: textSize),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
