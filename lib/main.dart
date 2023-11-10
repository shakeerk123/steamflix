
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:steamflix/app/views/loginscreen.dart';
import 'package:steamflix/app/views/mainscreen.dart';
import 'package:steamflix/app/views/moviescreen.dart';
import 'package:steamflix/app/views/profilescreen.dart';
import 'package:steamflix/app/views/searchscreen.dart';
import 'package:steamflix/app/views/tvshowscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Film Fusion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
      getPages: [
      //  GetPage(name: '/', page: () => const NavScreen()),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/main', page: () =>  MainScreen()),
        GetPage(name: '/search', page: () =>  const SearchScreen()),
       
        GetPage(name: '/profile', page: () => const ProfileScreen()),
        
        GetPage(
          name: '/movie/:id',
          page: () => MovieScreen(movieId: Get.parameters['id']!),
        ),
        GetPage(
          name: '/tv/:id',
          page: () => TVShowScreen(Get.parameters['id']!),
        ),
      ],
    );
  }
}
