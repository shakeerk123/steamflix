import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:steamflix/app/services/google_services.dart';
import 'package:steamflix/app/views/download/download.dart';
import 'package:steamflix/app/views/login/loginscreen.dart';
import 'package:steamflix/utils/consts.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey.shade400,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: backgroundPrimary,
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
            leading: const Icon(Icons.home),
            title: const Text(
              'Home',
            ),
            onTap: () {
              // Handle home navigation
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text('Search'),
            onTap: () {
              // Handle search navigation
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.download),
            title: const Text('Telegram Download'),
            onTap: () {
              // Handle downloads navigation
              Get.to(DownloadScreen());
            },
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('My List'),
            onTap: () {
              // Handle My List navigation
              Navigator.pop(context);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              await FirebaseServices().signOut();
              Get.off(const LoginScreen());
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help Center'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
