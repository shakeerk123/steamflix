
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:steamflix/app/controller/bottombar.dart';
import 'package:steamflix/app/utils/consts.dart';
import 'package:steamflix/app/widgets/bottomnavbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(  backgroundColor: background_primary,
    bottomNavigationBar: Obx(
        () => AnimatedContainer(
          duration: const Duration(milliseconds: 800),
          curve: Curves.fastLinearToSlowEaseIn,
          height: mainController.isVisible.value ? 75 : 0,
          child: BottomNavBar(),
        ),
      ),);
  }
}