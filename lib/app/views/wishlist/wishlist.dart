import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:steamflix/app/controller/main_controller.dart';
import 'package:steamflix/app/services/api.dart';

import 'package:steamflix/app/widgets/loadingscreen.dart';
import 'package:steamflix/utils/consts.dart';
 

class WishlistPage extends StatelessWidget {
  final MainController mainController = Get.put(MainController());

  WishlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      backgroundColor: background_primary,
      body: Obx(
        () => ListView.builder(
          itemCount: mainController.wishlist.length,
          itemBuilder: (context, index) {
            String movieId = mainController.wishlist.elementAt(index);

            return FutureBuilder(
              future: APIService().getMovieDetail(movieId),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) { 

                if(snapshot.hasData){
                  var status = snapshot.data!.title?.toString() ?? '';
                return GestureDetector(
                onTap: () {
                  _handleItemTap(movieId);
                },
                child: ListTile(
                  title: Text('${index + 1} : $status',style:noRecom ,),
                ),
              );
                }else{
                  return const LoadingScreen();
                }
                
               }
              
            );
          },
        ),
      ),
    );
  }

  void _handleItemTap(String movieId) {
    Get.toNamed('/movie/$movieId');
  }
}
