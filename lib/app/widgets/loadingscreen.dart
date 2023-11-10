import 'package:dotlottie_loader/dotlottie_loader.dart';
 
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:steamflix/app/utils/consts.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height ,
      width: size.width,
      color: background_primary,
      child: Center(
        child: SizedBox(width: 180,
        height: 180,
          child: DotLottieLoader.fromAsset("assets/loading.lottie", frameBuilder: ((context, dotLottie) {
            if(dotLottie!= null){
              return Lottie.memory(dotLottie.animations.values.single);
            }else{
              return const CircularProgressIndicator();
            }
          })),
        ),
      ),
    );
  }
}
