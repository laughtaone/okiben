import 'package:flutter/material.dart';



class CompDialogBar extends StatelessWidget {
  const CompDialogBar({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Divider(
        color: Colors.grey,
        thickness: 3,
        indent: 140,
        endIndent: 140,
      ),
    );
  }
}