import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:steamflix/app/utils/consts.dart';

import 'package:steamflix/app/widgets/splash_animation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..forward();

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    checkAnimationFinished();
  }

  checkAnimationFinished() {
  _controller.addStatusListener((status) {
    if (status == AnimationStatus.completed) {
      Get.offAllNamed("/main");
    }
  });
}

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: background_primary,
          body: Column(mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(child: SplashAnimation()),
              Column(
                children: [
                  SizedBox(height: 100,),
                  SizedBox(
                    width: 180,
                    height: 180,
                    child: DotLottieLoader.fromAsset("assets/running.lottie",
                        frameBuilder: ((context, dotLottie) {
                      if (dotLottie != null) {
                        return Lottie.memory(
                            dotLottie.animations.values.single);
                      } else {
                        return const CircularProgressIndicator();
                      }
                    })),
                  ),
                  SizedBox(
                    width: size.width * 0.5,
                    child: LinearProgressIndicator(
                        value: _animation.value,
                        backgroundColor: Colors.white,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.amber,
                        )),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text('Loading...',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600)),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
