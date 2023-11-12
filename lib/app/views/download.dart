// ignore_for_file: deprecated_member_use

import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:steamflix/app/utils/consts.dart';
import 'package:steamflix/app/widgets/bottomnavbar.dart';
import 'package:typethis/typethis.dart';
import 'package:url_launcher/url_launcher.dart';

class DownloadScreen extends StatelessWidget {
  const DownloadScreen({super.key});
  final String telegramGroupLink = "https://t.me/movies4k1";
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      backgroundColor: background_primary,
      body: Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          Image.asset(
            'assets/profile_background.jpg',
            fit: BoxFit.fitWidth,
            width: size.width,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 160,
              ),
              const TypeThis(
                string: 'Use This Bot to Download',
                speed: 300,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(
                width: 180,
                height: 180,
                child: DotLottieLoader.fromAsset("assets/download.lottie",
                    frameBuilder: ((context, dotLottie) {
                  if (dotLottie != null) {
                    return Lottie.memory(dotLottie.animations.values.single);
                  } else {
                    return const CircularProgressIndicator();
                  }
                })),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    launchTelegramGroup();
                  },
                  child: SizedBox(
                    width: 180,
                    height: 180,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        DotLottieLoader.fromAsset(
                          "assets/button.lottie",
                          frameBuilder: (context, dotLottie) {
                            if (dotLottie != null) {
                              return Lottie.memory(
                                  dotLottie.animations.values.single);
                            } else {
                              return const Text("Click me");
                            }
                          },
                        ),
                        const Text(
                          "Click me",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void launchTelegramGroup() async {
    if (await canLaunch(telegramGroupLink)) {
      await launch(telegramGroupLink);
    } else {
      Get.snackbar(
        'Error',
        'Could not open the telegram link.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
