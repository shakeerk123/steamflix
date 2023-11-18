import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:steamflix/app/controller/main_controller.dart';

class WishlistPage extends StatelessWidget {
  final MainController mainController = Get.put(MainController());

   WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: mainController.wishlist.length,
          itemBuilder: (context, index) {
            // Fetch details of each item from your API or local data
            String itemId = mainController.wishlist.elementAt(index);
            
            
            // Display wishlist items (you can customize this based on your model)
            return ListTile(
              title: Text('Item ID: $itemId'),
              // Add more details or actions as needed
            );
          },
        ),
      ),
    );
  }
}
