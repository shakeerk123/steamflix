import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishlistController extends GetxController {
  final RxSet<String> wishlist = <String>{}.obs;
  static const String wishlistKey = 'wishlist';

  @override
  void onInit() {
    super.onInit();
    _loadWishlist();
  }

  Future<void> _loadWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    final wishlistSet = prefs.getStringList(wishlistKey) ?? [];
    wishlist.addAll(wishlistSet);
  }

  void _saveWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(wishlistKey, wishlist.toList());
  }

  // Check if a movie/show is in the wishlist
  bool isInWishlist(String movieId) => wishlist.contains(movieId);

  // Add to wishlist
  void addToWishlist(String movieId) {
    if (!wishlist.contains(movieId)) {
      wishlist.add(movieId);
      _saveWishlist();
      update(); // Notify listeners about the change
      print('Movie $movieId added to wishlist');
    } else {
      print('Movie $movieId is already in the wishlist');
    }
  }

  // Remove from wishlist
  void removeFromWishlist(String movieId) {
    wishlist.remove(movieId);
    _saveWishlist();
    update(); // Notify listeners about the change
    print('Movie $movieId removed from wishlist');
  }
}
