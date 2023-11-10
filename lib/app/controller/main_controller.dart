import 'package:get/get.dart';
import 'package:steamflix/app/models/TvShow.dart';
import 'package:steamflix/app/models/popular_movies_model.dart';
import 'package:steamflix/app/services/api.dart';
 
class MainController extends GetxController {
  var isVisible = true.obs;
  var isLoading = true.obs;
  var currentIndex = 0.obs;

  var popularMovies = <Results>[].obs;
  var malayalamMovies = <Results>[].obs;
  var topRatedMovie = <Results>[].obs;
  var nowPLayingMovie = <Results>[].obs;
  var popularShows = <TvShow>[].obs;
  var topRatedShows = <TvShow>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    topRatedShows.value = await APIService().getTopRatedShow();
    malayalamMovies.value = await APIService().getMalayamLanguage();
    popularMovies.value = await APIService().getPopularMovies();
    topRatedMovie.value = await APIService().getTopRatedMovie();
    popularShows.value = await APIService().getRecommendedTvShows('1396');
    nowPLayingMovie.value = await APIService().getNowPLayingMovie();

    isLoading.value = false;
  }
   void onTap(int index) {
    currentIndex.value = index;
  }
 
}

