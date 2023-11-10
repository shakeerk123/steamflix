 
import 'package:flutter/material.dart';
import 'package:steamflix/app/utils/consts.dart';

Widget contentTextTitle(
    String title, Function()? onTap, bool isSelected, BuildContext context) {
  return InkWell(
    onTap: () {
      onTap!();
      Navigator.pop(context);
    },
    child: Text(
      title,
      style: TextStyle(
        color: isSelected ? Colors.white : inactive_accent,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
