import 'package:flutter/material.dart';


class CompDialogBar extends StatelessWidget {
  const CompDialogBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Container(
        height: 4,
        width: 60,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }
}