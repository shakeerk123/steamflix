import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:steamflix/app/controller/fav_controller.dart';
import 'package:steamflix/app/services/api.dart';
import 'package:steamflix/app/widgets/loadingscreen.dart';
import 'package:steamflix/utils/consts.dart';

class WishlistPage extends StatelessWidget {
  final WishlistController wishlistController = Get.put(WishlistController());

  WishlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background_primary,
      body: Obx(
        () {
          if (wishlistController.wishlist.isEmpty) {
            
            return Center(
              child: Text(
                'Wishlist is empty',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            );
          } else {
            // Display wishlist items
            return ListView.builder(
              itemCount: wishlistController.wishlist.length,
              itemBuilder: (context, index) {
                String movieId = wishlistController.wishlist.elementAt(index);

                return FutureBuilder(
                  future: APIService().getMovieDetail(movieId),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      var status = snapshot.data!.title?.toString() ?? '';
                      return Dismissible(
                        key: Key(movieId),
                        onDismissed: (direction) {
                          _handleItemDelete(movieId);
                        },
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 16),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            _handleItemTap(movieId);
                          },
                          child: ListTile(
                            title: Text('${index + 1} : $status', style: noRecom),
                          ),
                        ),
                      );
                    } else {
                      return const LoadingScreen();
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  void _handleItemTap(String movieId) {
    Get.toNamed('/movie/$movieId');
  }

  void _handleItemDelete(String movieId) {
    wishlistController.removeFromWishlist(movieId);
  }
}
