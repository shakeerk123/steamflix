// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:steamflix/app/models/popular_movies_model.dart';
import 'package:steamflix/app/services/api.dart';
import 'package:steamflix/app/utils/consts.dart';
import 'package:steamflix/app/widgets/circularbutton.dart';
import 'package:steamflix/app/widgets/customlistmovie.dart';
import 'package:steamflix/app/widgets/loadingscreen.dart';
import 'package:steamflix/app/widgets/textcontainer.dart';
import 'package:steamflix/app/widgets/titletext.dart';
import 'package:unicons/unicons.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieScreen extends StatefulWidget {
  final String movieId;
  const MovieScreen({super.key, required this.movieId});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  bool isLoading = true;
  late List<Results> recommendedMovies;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      recommendedMovies = await APIService().getRecommendedMovie(widget.movieId);
    } catch (e) {
      log('Error fetching recommended movies: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> playTrailer(BuildContext context, String? trailerLink) async {
    if (trailerLink != null) {
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
        log('Error launching trailer link: $e');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Trailer link is null or empty.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
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
                                  ? const AssetImage('assets/LoadingImage.png')
                                      as ImageProvider
                                  : NetworkImage(
                                      "https://image.tmdb.org/t/p/original${snapshot.data!.backdropPath}"),
                              fit: BoxFit.cover,
                            )),
                          ),
                          Container(
                            width: size.width,
                            height: size.height * 0.40 > 300
                                ? size.height * 0.40
                                : 300,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.transparent,
                                background_primary.withOpacity(0.50),
                                background_primary.withOpacity(0.75),
                                background_primary.withOpacity(0.90),
                                background_primary.withOpacity(1.00),
                              ],
                            )),
                          ),
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
                                  style: const TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  snapshot.data!.title.toString(),
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  children: [
                                    circularButton(
                                      UniconsLine.play,
                                      onTap: () {
                                        HapticFeedback.lightImpact();
                                        APIService()
                                            .getTrailerLink(
                                                snapshot.data.movieId.toString(),
                                                "movie")
                                            .then((value) =>
                                                playTrailer(context, value));
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
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
                                      const Color(0xFF14303B));
                                },
                              ),
                            );
                          } else {
                            return textContainer(
                                'Loading',
                                const EdgeInsets.only(right: 8),
                                const Color(0xFF14303B));
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
                          titleText('Recommendations'),
                          CustomListMovie(popularMovies: recommendedMovies)
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
