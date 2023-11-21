import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:steamflix/app/controller/main_controller.dart';
import 'package:steamflix/utils/consts.dart';
import 'package:steamflix/app/widgets/customcarouselslider.dart';
import 'package:steamflix/app/widgets/customlistmovie.dart';
import 'package:steamflix/app/widgets/loadingscreen.dart';
import 'package:steamflix/app/widgets/sectiontext.dart';

class HomeScreen extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  final MainController mainController = Get.put(MainController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      
      extendBody: true,
      body: Obx(
        () => mainController.isLoading.value
            ? const LoadingScreen()
            : Container(
                height: size.height ,
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
                    sectionText('Animated', 'Movies'),
                    CustomListMovie(
                        popularMovies: mainController.animatedMovies),
                    sectionText('TOP Rated', 'Movies'),
                    CustomListMovie(
                        popularMovies: mainController.topRatedMovie),
                    sectionText('Popular', 'Movies'),
                    CustomListMovie(
                        popularMovies: mainController.popularMovies),
                    sectionText('Malayalam', 'Movies'),
                    CustomListMovie(
                        popularMovies: mainController.malayalamMovies),
                    sectionText('Popular', 'Shows'),
                    CustomListTv(data: mainController.popularShows),
                    sectionText('NOW Playing', 'Movies'),
                    CustomListMovie(
                        popularMovies: mainController.nowPLayingMovie),
                  ],
                ),
              ),
      ),
    );
  }
}
