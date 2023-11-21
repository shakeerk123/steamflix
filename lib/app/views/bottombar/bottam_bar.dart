
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:steamflix/app/controller/main_controller.dart';
import 'package:steamflix/app/views/download/tab_screen.dart';
import 'package:steamflix/app/views/home/home_screen.dart';
import 'package:steamflix/app/views/news/new_screen.dart';
import 'package:steamflix/app/views/search/searchscreen.dart';
import 'package:unicons/unicons.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
   final MainController controller = Get.put(MainController());
  List pages = [ HomeScreen(),const SearchScreen(), NewsHomeScreen(),const TabView()  ];

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
        body: Obx(() => pages[controller.currentIndex.value]),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
              
              backgroundColor: Colors.amber,
              onTap: controller.onTap,
              currentIndex: controller.currentIndex.value,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.grey,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: const [
                BottomNavigationBarItem(icon: Icon(UniconsLine.home_alt), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(UniconsLine.search), label: "search"),
                    BottomNavigationBarItem(
                    icon: Icon(UniconsLine.newspaper), label: "books"),
                BottomNavigationBarItem(
                    icon: Icon(UniconsLine.favorite), label: "favorite"),
              ]),
        ));
  }
}
