import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:steamflix/app/views/news/new_screen.dart';
import 'package:steamflix/app/views/login/loginscreen.dart';
import 'package:steamflix/app/views/home/home_screen.dart';
import 'package:steamflix/app/views/movie_detail/moviescreen.dart';
import 'package:steamflix/app/views/search/searchscreen.dart';
import 'package:steamflix/app/views/tvshow_detail/tvshowscreen.dart';
import 'package:steamflix/app/views/download/download.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StramFlix',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
      getPages: [
        //  GetPage(name: '/', page: () => const NavScreen()),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/main', page: () => HomeScreen()),
        GetPage(name: '/search', page: () => const SearchScreen()),
        GetPage(name: '/news', page: () => NewsHomeScreen()),
        GetPage(
          name: '/download',
          page: () => const DownloadScreen(),
        ),
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
