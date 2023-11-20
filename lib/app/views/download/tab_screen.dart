import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:steamflix/app/widgets/bottomnavbar.dart';
import 'package:steamflix/app/widgets/tabview.dart';
import 'package:steamflix/app/widgets/customlistmovie.dart';
import 'package:steamflix/utils/consts.dart';

import '../../controller/main_controller.dart';

class TabView extends StatefulWidget {
  const TabView({Key? key}) : super(key: key);

  @override
  _TabViewState createState() => _TabViewState();
}

class _TabViewState extends State<TabView> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final MainController mainController = Get.put(MainController());

  final _tabs = [
    const Tab(text: 'Thriller'),
    const Tab(text: 'Game'),
    const Tab(text: 'Hot'),
    const Tab(text: 'Hot'),
  ];

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      backgroundColor: background_primary,
      body: Column(
        children: [
          Container(
            height: kToolbarHeight + 8.0,
            padding: const EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0)),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0)),
                  color: Colors.white),
              labelColor: Colors.black,
              unselectedLabelColor: Colors.white,
              tabs: _tabs,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children:  [
                // Content for 'Thriller' tab
               CustomListMovie( popularMovies: mainController.animatedMovies),

                // Content for 'Game' tab
             //   CustomGrid(popularMovies: mainController.animatedMovies),

                // Content for 'Hot' tab
                MovieGridView(tabName: 'Hot'),

                // Content for the second 'Hot' tab
                MovieGridView(tabName: 'Hot'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MovieGridView extends StatelessWidget {
  final String tabName;

  const MovieGridView({Key? key, required this.tabName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Replace the following with your actual data fetching logic or use sample data
    List<String> movies = List.generate(20, (index) => '$tabName Movie ${index + 1}');

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        
        
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return Card(
          child: Center(
            child: Text(movies[index]),
          ),
        );
      },
    );
  }
}
