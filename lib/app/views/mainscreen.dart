
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:steamflix/app/controller/bottombar.dart';
import 'package:steamflix/app/utils/consts.dart';
import 'package:steamflix/app/widgets/bottomnavbar.dart';
import 'package:steamflix/app/widgets/customcarouselslider.dart';
import 'package:steamflix/app/widgets/customlistmovie.dart';
import 'package:steamflix/app/widgets/loadingscreen.dart';
import 'package:steamflix/app/widgets/sectiontext.dart';

class MainScreen extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  final MainController mainController = Get.put(MainController());

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Obx(
        () => AnimatedContainer(
          duration: const Duration(milliseconds: 800),
          curve: Curves.fastLinearToSlowEaseIn,
          height: mainController.isVisible.value ? 75 : 0,
          child: BottomNavBar(),
        ),
      ),
      extendBody: true,
      body: Obx(
        () => mainController.isLoading.value
            ? const LoadingScreen()
            : Container(
                height: size.height,
                width: size.width,
                color: background_primary,
                child: ListView(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  controller: _scrollController,
                  shrinkWrap: true,
                  children: [
                    CustomCarouselSlider(data: mainController.topRatedShows),
                    sectionText('Popular', 'Movies'),
                    CustomListMovie(popularMovies: mainController.popularMovies),
                    sectionText('TOP Rated', 'Movies'),
                    CustomListMovie(popularMovies: mainController.topRatedMovie),
                    sectionText('Popular', 'Shows'),
                    CustomListTv(data: mainController.popularShows),
                    sectionText('NOW Playing', 'Movies'),
                    CustomListMovie(popularMovies: mainController.nowPLayingMovie),
                  ],
                ),
              ),
      ),
    );
  }
}
