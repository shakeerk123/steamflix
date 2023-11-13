import 'package:flutter/material.dart';
import 'package:steamflix/utils/consts.dart';

class MovieGradient extends StatelessWidget {
  const MovieGradient({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height * 0.40 > 300
          ? size.height * 0.40
          : 300,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.transparent,
          Colors.transparent,
          background_primary.withOpacity(0.50),
          background_primary.withOpacity(0.75),
          background_primary.withOpacity(0.90),
          background_primary.withOpacity(1.00),
        ],
      )),
    );
  }
}