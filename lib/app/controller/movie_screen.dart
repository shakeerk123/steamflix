// ignore_for_file: deprecated_member_use

import 'dart:developer';
import 'package:get/get.dart';
import 'package:steamflix/app/models/MovieDetail.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:steamflix/app/models/popular_movies_model.dart';
import 'package:steamflix/app/services/api.dart';

class MovieController extends GetxController {
  var isLoading = true.obs;
  var movieDetail = Rx<MovieDetail?>(null);
  var recommendedMovies = <Results>[].obs;
  late String movieId;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    try {
      recommendedMovies.assignAll(await APIService().getRecommendedMovie(movieId));
      movieDetail.value = await APIService().getMovieDetail(movieId);
    } catch (e) {
      log('Error fetching movie details: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> playTrailer(String trailerLink) async {
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
}
