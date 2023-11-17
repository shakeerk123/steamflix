
// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:steamflix/utils/consts.dart';
import 'package:unicons/unicons.dart';

class BottomNavBarController extends GetxController {
  var currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;
  }
}

class BottomNavBar extends StatelessWidget {
  final BottomNavBarController controller = Get.put(BottomNavBarController());

   BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.fromLTRB(8, 8, 8, 16),
      decoration: BoxDecoration(
        color: accent_t.withOpacity(0.95),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              controller.changePage(0);
              Get.toNamed('/main');
            },
            icon: Icon(
              UniconsLine.home_alt,
              color: controller.currentIndex == 0 ? Colors.white : inactive_accent,
            ),
          ),
          IconButton(
            onPressed: () {
              controller.changePage(1);
              Get.toNamed('/search');
            },
            icon: Icon(
              UniconsLine.search,
              color: controller.currentIndex == 1 ? Colors.white : inactive_accent,
            ),
          ),
          IconButton(
            onPressed: () {
              controller.changePage(2);
              Get.toNamed('/download');
            },
            icon: Icon(
              UniconsLine.download_alt,
              color: controller.currentIndex == 2 ? Colors.white : inactive_accent,
            ),
          ),
          IconButton(
            onPressed: () {
              controller.changePage(3);
              Get.toNamed('/news');
            },
            icon: Icon(
              UniconsLine.newspaper,
              color: controller.currentIndex == 3 ? Colors.white : inactive_accent,
            ),
          ),
           IconButton(
            onPressed: () {
              controller.changePage(4);
              Get.toNamed('/profile');
            },
            icon: Icon(
              UniconsLine.user,
              color: controller.currentIndex == 4 ? Colors.white : inactive_accent,
            ),
          ),
        ],
      ),
    );
  }
}
