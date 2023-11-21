import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:steamflix/app/views/bottombar/bottam_bar.dart';
import 'package:steamflix/app/views/news/new_screen.dart';
import 'package:steamflix/app/views/login/loginscreen.dart';
import 'package:steamflix/app/views/movie_detail/moviescreen.dart';
import 'package:steamflix/app/views/profile/profilescreen.dart';
import 'package:steamflix/app/views/search/searchscreen.dart';
import 'package:steamflix/app/views/splash/splash_screen.dart';
import 'package:steamflix/app/views/tvshow_detail/tvshowscreen.dart';
import 'package:steamflix/app/views/download/download.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCvq71ZPd6EjGFL0tx12WNxWU6DlgQO-Jo",
          appId: "1:656030408311:android:264115661a4effb32eb072",
          messagingSenderId: "656030408311",
          projectId: "streamflix-f7242"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StreamFlix',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const LoginScreen();
          } else {
            return const SplashScreen();
          }
        },
      ),
      getPages: [
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/main', page: () =>  MainPage()),
        GetPage(name: '/search', page: () => const SearchScreen()),
        GetPage(name: '/news', page: () => NewsHomeScreen()),
        GetPage(name: '/profile', page: () =>  const ProfileScreen()),
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
