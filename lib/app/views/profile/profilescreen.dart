
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:steamflix/app/services/google_services.dart';
import 'package:steamflix/app/views/login/loginscreen.dart';

import 'package:steamflix/utils/consts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: background_primary,
        
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Image.asset(
                  "assets/profile_background.jpg",
                  height: h / 5,
                  fit: BoxFit
                      .cover, // Make sure the image covers the entire area
                ),
                Positioned(
                  bottom: -40,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        FirebaseAuth.instance.currentUser!.photoURL!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),
            Center(
              child: Column(
                children: [
                  Text(
                    FirebaseAuth.instance.currentUser!.displayName!
                        .toUpperCase(),
                    style: name,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${FirebaseAuth.instance.currentUser!.email}',
                    style: noRecom,
                  ),
                ],
              ),
            ),
            IconButton(onPressed: ()async{
            await  FirebaseServices().signOut();
            Get.off( const LoginScreen());
            }, icon: const Icon(Icons.logout,color: Colors.white,))
          ],
        ));
  }
}

