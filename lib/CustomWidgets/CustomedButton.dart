import 'package:flutter/material.dart';

class CustomedButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  const CustomedButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Container(
          height: 45,
          width: 290,
          color: Colors.white,
          child: Center(
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
