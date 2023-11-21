// ignore_for_file: deprecated_member_use
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:steamflix/app/controller/main_controller.dart';
import 'package:steamflix/app/models/popular_movies_model.dart';
import 'package:steamflix/app/services/api.dart';
import 'package:steamflix/app/widgets/movie_detail_widgets/gradient.dart';
import 'package:steamflix/app/widgets/movie_detail_widgets/play_button_blur.dart';
import 'package:steamflix/utils/consts.dart';

import 'package:steamflix/app/widgets/customlistmovie.dart';
import 'package:steamflix/app/widgets/loadingscreen.dart';
import 'package:steamflix/app/widgets/textcontainer.dart';
import 'package:steamflix/app/widgets/titletext.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieScreen extends StatefulWidget {
  final String movieId;

  const MovieScreen({Key? key, required this.movieId}) : super(key: key);

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  final MainController mainController = Get.put(MainController());
  bool isLoading = true;
  late List<Results> recommendedMovies;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      recommendedMovies =
          await APIService().getRecommendedMovie(widget.movieId);
    } catch (e) {
      log('Error fetching recommended movies: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> playTrailer(BuildContext context, String trailerLink) async {
    try {
      if (await canLaunch(trailerLink)) {
        await launch(trailerLink);
      } else {
        Get.snackbar(
          'Error',
          'Could not open the trailer link.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (mainController.isInWishlist(widget.movieId)) {
            mainController.removeFromWishlist(widget.movieId);
          } else {
            mainController.addToWishlist(widget.movieId);
          }
        },
        child: Obx(() => Icon(
              mainController.isInWishlist(widget.movieId)
                  ? Icons.favorite
                  : Icons.favorite_border,
            )),
      ),
      
      backgroundColor: background_primary,
      body: isLoading
          ? const LoadingScreen()
          : FutureBuilder(
              future: APIService().getMovieDetail(widget.movieId),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  var status = snapshot.data!.status?.toString() ?? '';
                  var releaseDate =
                      snapshot.data!.releaseDate?.toString() ?? '';
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
                                            'assets/LoadingImage.png')
                                        as ImageProvider
                                    : NetworkImage(
                                        "https://image.tmdb.org/t/p/original${snapshot.data!.backdropPath}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          MovieGradient(size: size),
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
                                            "movie")
                                        .then((value) =>
                                            playTrailer(context, value));
                                  },
                                  child: const PlayButton(),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: size.width,
                        margin: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              snapshot.data!.voteAverage
                                  .toString()
                                  .substring(0, 3),
                              style: voteAvg,
                            ),
                            Text(
                              snapshot.data!.title.toString(),
                              style: name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      FutureBuilder(
                        future: APIService()
                            .getMovieGeneres(widget.movieId, 'movie'),
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
                                    const Color(0xFF14303B),
                                  );
                                },
                              ),
                            );
                          } else {
                            return textContainer(
                              'Loading',
                              const EdgeInsets.only(right: 8),
                              const Color(0xFF14303B),
                            );
                          }
                        },
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          titleText('Status'),
                          Row(
                            children: [
                              textContainer(
                                status,
                                const EdgeInsets.only(
                                    left: 8, right: 8, bottom: 8),
                                const Color(0xFF382E39),
                              ),
                              textContainer(
                                'Release : ${DateFormat.yMMMMd().format(DateTime.parse(releaseDate))}',
                                const EdgeInsets.only(
                                    left: 8, right: 8, bottom: 8),
                                const Color(0xFF545551),
                              ),
                            ],
                          ),
                          titleText('Overview'),
                          textContainer(
                            snapshot.data!.overview.toString().isEmpty ||
                                    snapshot.data!.overview.toString() == 'null'
                                ? 'No overview available :('
                                : snapshot.data!.overview.toString(),
                            const EdgeInsets.all(8),
                            const Color(0xFF0F1D39),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              titleText('Recommendations'),
                              // ignore: unnecessary_null_comparison
                              recommendedMovies != null &&
                                      recommendedMovies.isNotEmpty
                                  ? CustomListMovie(
                                      popularMovies: recommendedMovies)
                                  : const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'No recommendations available....',
                                        style: noRecom,
                                      ),
                                    ),
                            ],
                          ),
                        ],
                      )
                    ],
                  );
                }
                return const LoadingScreen();
              },
            ),
    );
  }
}
