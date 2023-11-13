import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:steamflix/app/controller/main_controller.dart';
import 'package:steamflix/utils/consts.dart';
import 'package:steamflix/app/widgets/bottomnavbar.dart';
import 'package:steamflix/app/widgets/loadingscreen.dart';
import 'package:steamflix/app/widgets/news_card.dart';

class NewsHomeScreen extends StatelessWidget {
  final MainController newsController = Get.put(MainController());

    NewsHomeScreen({super.key});

  Future<void> _refresh() async {
    await newsController.fetchArticles();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      resizeToAvoidBottomInset: false,
      backgroundColor: background_primary,
      body: Stack(
        children: [
          Image.asset(
            'assets/backdrop.png',
            fit: BoxFit.fitWidth,
            width: size.width,
          ),
          Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _refresh,
                  child: Obx(
                    () => newsController.futureArticles.isEmpty
                        ? const LoadingScreen()
                        : _buildNewsList(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNewsList() {
    return ListView.builder(
      itemCount: newsController.futureArticles.length,
      itemBuilder: (context, index) {
        final article = newsController.futureArticles[index];
        return Stack(
          children: [
            NewsCard(article: article),
          ],
        );
      },
    );
  }
}