import 'dart:developer';

import 'package:get/get.dart';
import 'package:steamflix/app/models/TvShow.dart';
import 'package:steamflix/app/models/article_model.dart';
import 'package:steamflix/app/models/popular_movies_model.dart';
import 'package:steamflix/app/services/api.dart';
import 'package:steamflix/app/services/new_api.dart';
 
class MainController extends GetxController {
  var isVisible = true.obs;
  var isLoading = true.obs;
  var currentIndex = 0.obs;
  final futureArticles = <Article>[].obs;


  var popularMovies = <Results>[].obs;
 
  var animatedMovies = <Results>[].obs;
  var malayalamMovies = <Results>[].obs;
  var topRatedMovie = <Results>[].obs;
  var nowPLayingMovie = <Results>[].obs;
  var popularShows = <TvShow>[].obs;
  var topRatedShows = <TvShow>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
    fetchArticles();
  }

  Future<void> fetchData() async {
    topRatedShows.value = await APIService().getTopRatedShow();
    malayalamMovies.value = await APIService().getMalayamLanguage();
    popularMovies.value = await APIService().getPopularMovies();
    topRatedMovie.value = await APIService().getTopRatedMovie();
    popularShows.value = await APIService().getRecommendedTvShows('1396');
    nowPLayingMovie.value = await APIService().getNowPLayingMovie();
    animatedMovies.value = await APIService().getAnimated();


    isLoading.value = false;
  }
   void onTap(int index) {
    currentIndex.value = index;
  }
  Future<void> fetchArticles() async {
    try {
      var articles = await NewsService().getEntertainmentNews();
      futureArticles.assignAll(articles);
    } catch (error) {
      log('Error fetching articles: $error');
    }
  }
 
}

