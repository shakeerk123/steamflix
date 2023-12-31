// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:steamflix/app/models/TvShow.dart';
import 'package:steamflix/app/services/api.dart';
import 'package:steamflix/app/widgets/movie_detail_widgets/gradient.dart';
import 'package:steamflix/app/widgets/movie_detail_widgets/play_button_blur.dart';
import 'package:steamflix/utils/consts.dart';
import 'package:steamflix/app/widgets/customlistmovie.dart';
import 'package:steamflix/app/widgets/loadingscreen.dart';
import 'package:steamflix/app/widgets/seasonlist.dart';
import 'package:steamflix/app/widgets/textcontainer.dart';
import 'package:steamflix/app/widgets/titletext.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controller/main_controller.dart';

class TVShowScreen extends StatefulWidget {
  const TVShowScreen(this.movieId, {super.key});
  final String movieId;

  @override
  State<TVShowScreen> createState() => _TVShowScreenState();
}

class _TVShowScreenState extends State<TVShowScreen> {
   final MainController mainController = Get.put(MainController());
  bool isLoading = true;
  late List<TvShow> recommendedTvShows;
  Future<void> playTrailer(BuildContext context, String trailerLink) async {
    try {
      if (await canLaunch(trailerLink)) {
        await launch(trailerLink);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not open the trailer link.'),
          ),
        );
      }
    } catch (e) {
      
      log('Error: $e');
    }
  }

  Future<void> fetchData() async {
    recommendedTvShows =
        await APIService().getRecommendedTvShows(widget.movieId);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  var selectedSeason = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold( 
      backgroundColor: background_primary,
      body: isLoading
          ? const LoadingScreen()
          : FutureBuilder(
              future: APIService().getTvShowDetail(widget.movieId),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  var status = snapshot.data!.status.toString();
                  var releaseDate = snapshot.data!.firstAirDate.toString();
                  var seasonCount = snapshot.data!.numberOfSeasons;
                  var seasonList = [];
                  for (var i = 1; i <= seasonCount; i++) {
                    seasonList.add("Season $i");
                  }
                  return ListView(
                      scrollDirection: Axis.vertical,
                      physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics()),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: size.width,
                              height: size.height * 0.40 > 300
                                  ? size.height * 0.40
                                  : 300,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: snapshot.data!.backdropPath == null
                                      ? const AssetImage(
                                              "assets/LoadingImage.png")
                                          as ImageProvider
                                      : NetworkImage(
                                          "https://image.tmdb.org/t/p/original${snapshot.data!.backdropPath}",
                                        ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            MovieGradient(size: size),
                            Container(
                              width: size.width,
                              height: size.height * 0.35 > 300
                                  ? size.height * 0.35
                                  : 300,
                              margin: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                      snapshot.data!.voteAverage
                                          .toString()
                                          .substring(0, 3),
                                      style: voteAvg),
                                  Text(snapshot.data!.name.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: name),
                                ],
                              ),
                            ),
                            Positioned(
                              width: size.width * 1.0,
                              height: size.height * 0.4,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          HapticFeedback.lightImpact();
                                          APIService()
                                              .getTrailerLink(
                                                  snapshot.data!.id.toString(),
                                                  "tv")
                                              .then((value) =>
                                                  playTrailer(context, value));
                                        },
                                        child: const PlayButton())
                                  ]),
                            ),
                          ],
                        ),
                        FutureBuilder(
                          future: APIService()
                              .getMovieGeneres(widget.movieId, "tv"),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                height: 36,
                                width: size.width,
                                margin: const EdgeInsets.only(left: 8),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    return textContainer(
                                        snapshot.data![index].name.toString(),
                                        const EdgeInsets.only(right: 8),
                                        const Color(0xFF14303B));
                                  },
                                ),
                              );
                            } else {
                              return textContainer(
                                  "Loading",
                                  const EdgeInsets.all(8),
                                  const Color(0xFF14303B));
                            }
                          },
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            titleText("Status"),
                            Row(
                              children: [
                                textContainer(
                                    status,
                                    const EdgeInsets.only(
                                        left: 8, right: 8, bottom: 8),
                                    const Color(0xFF382E39)),
                                textContainer(
                                    "Release: ${DateFormat.yMMMMd().format(DateTime.parse(releaseDate))}",
                                    const EdgeInsets.only(
                                        left: 8, right: 8, bottom: 8),
                                    const Color(0xFF545551)),
                              ],
                            ),
                            titleText("Overview"),
                            textContainer(
                                snapshot.data!.overview.toString().isEmpty ||
                                        snapshot.data!.overview.toString() ==
                                            "null"
                                    ? "No overview available"
                                    : snapshot.data!.overview.toString(),
                                const EdgeInsets.all(8),
                                const Color(0xFF0F1D39)),
                            titleText("Seasons"),
                            Container(
                              height: 36,
                              width: size.width,
                              margin: const EdgeInsets.only(left: 8),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: seasonCount,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      HapticFeedback.lightImpact();
                                      setState(() {
                                        selectedSeason = index;
                                      });
                                    },
                                    child: textContainer(
                                        seasonList[index].toString(),
                                        const EdgeInsets.only(right: 8),
                                        index == selectedSeason
                                            ? const Color(0xFF545551)
                                            : const Color(0xFF14303B)),
                                  );
                                },
                              ),
                            ),
                            SeasonList(
                                seasonNumber: selectedSeason + 1,
                                movieId: widget.movieId),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                titleText('Recommendations'),
                                // ignore: unnecessary_null_comparison
                                recommendedTvShows != null &&
                                        recommendedTvShows.isNotEmpty
                                    ? CustomListTv(data: recommendedTvShows)
                                    : const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'No recommendations available....',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ],
                        )
                      ]);
                } else {
                  return const LoadingScreen();
                }
              },
            ),
    );
  }
}
