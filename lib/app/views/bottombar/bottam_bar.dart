// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:steamflix/app/controller/main_controller.dart';
import 'package:steamflix/app/views/home/home_screen.dart';
import 'package:steamflix/app/views/news/new_screen.dart';
import 'package:steamflix/app/views/search/searchscreen.dart';
import 'package:steamflix/app/views/wishlist/wishlist.dart';
import 'package:steamflix/utils/consts.dart';
import 'package:unicons/unicons.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final MainController controller = Get.put(MainController());

  List pages = [
    HomeScreen(),
    const SearchScreen(),
    NewsHomeScreen(),
    WishlistPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => pages[controller.currentIndex.value]),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: backgroundPrimary,
              onTap: controller.onTap,
              currentIndex: controller.currentIndex.value,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(UniconsLine.home_alt), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(UniconsLine.search), label: "search"),
                BottomNavigationBarItem(
                    icon: Icon(UniconsLine.newspaper), label: "books"),
                BottomNavigationBarItem(
                    icon: Icon(UniconsLine.heart), label: "favorite"),
              ]),
        ));
  }
}
