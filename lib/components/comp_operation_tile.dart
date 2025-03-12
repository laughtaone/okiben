
import 'package:flutter/material.dart';



class CompOperationTile extends StatelessWidget {
  const CompOperationTile({super.key,
    required this.buttonText,
    required this.icon,
    required this.onPressed
  });

  final String buttonText;
  final IconData icon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: (Theme.of(context).brightness == Brightness.light)
            ? Color(0xffe8e8e8)
            : Color(0xff464646),
          fixedSize: Size(double.infinity, 70),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: Row(
            children: [
              Icon(icon, size: 23),
              Expanded(
                child: Center(
                  child: Text(
                    buttonText,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold
                    )
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
