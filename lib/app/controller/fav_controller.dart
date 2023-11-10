import 'package:get/get.dart';

class WatchlistController extends GetxController {
  RxList<String> watchlist = <String>[].obs;

  void addToWatchlist(String movieId) {
    if (!watchlist.contains(movieId)) {
      watchlist.add(movieId);
    }
  }

  void removeFromWatchlist(String movieId) {
    watchlist.remove(movieId);
  }

  bool isInWatchlist(String movieId) {
    return watchlist.contains(movieId);
  }
}
