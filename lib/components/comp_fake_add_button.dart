import 'package:flutter/material.dart';
import 'package:okiben/customs.dart';



class CompFakeAddButton extends StatelessWidget {
  const CompFakeAddButton({super.key,
    required this.sizeOneSide,
    this.customBorderRadius = 5,
    this.customHorizontalMargin = 3,
  });

  final double sizeOneSide;
  final double customBorderRadius;
  final double customHorizontalMargin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizeOneSide,
      height: sizeOneSide,
      margin: EdgeInsets.symmetric(horizontal: customHorizontalMargin),
      decoration: BoxDecoration(
        color: addIconButtonColor(isDarkMode:  Theme.of(context).brightness == Brightness.dark),
        borderRadius: BorderRadius.circular(customBorderRadius),
      ),
      child: Center(child: Icon(
        Icons.add_outlined,
        size: 18,
        color: (Theme.of(context).brightness == Brightness.light) ? Colors.white : Colors.black
      ))
    );
  }
}