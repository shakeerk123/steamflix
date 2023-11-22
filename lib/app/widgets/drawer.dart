import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:steamflix/app/controller/main_controller.dart';
import 'package:steamflix/app/services/google_services.dart';
import 'package:steamflix/app/views/home/home_screen.dart';
import 'package:steamflix/app/views/login/loginscreen.dart';
import 'package:steamflix/utils/consts.dart';

class AppDrawer extends StatelessWidget {
  final MainController controller = Get.put(MainController());
   AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(100, 22, 44, 33),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                      FirebaseAuth.instance.currentUser!.photoURL!),
                ),
                const SizedBox(height: 10),
                Text(
                  FirebaseAuth.instance.currentUser!.displayName!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${FirebaseAuth.instance.currentUser!.email}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: white,
            ),
            title: const Text('Home', style: TextStyle(color: Colors.white)),
            onTap: () {
             
              
            },
          ),
          ListTile(
            leading: Icon(
              Icons.search,
              color: white,
            ),
            title: const Text('Search', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Handle search navigation
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.list,
              color: white,
            ),
            title: const Text('My List', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Handle My List navigation
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: white,
            ),
            title: const Text('Logout', style: TextStyle(color: Colors.white)),
            onTap: () async {
              await FirebaseServices().signOut();
              Get.off(const LoginScreen());
            },
          ),
        ],
      ),
    );
  }
}
