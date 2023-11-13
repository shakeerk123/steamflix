import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:steamflix/utils/consts.dart';
import 'package:unicons/unicons.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
        child: BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: 1.0, sigmaY: 1.0),
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(50),
                color: white.withOpacity(0.5),
              ),
              child: const Row(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  Icon(UniconsLine.play)
                ],
              ),
            )));
  }
}