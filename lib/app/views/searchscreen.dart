 
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lottie/lottie.dart';
import 'package:steamflix/app/services/api.dart';
import 'package:steamflix/app/utils/consts.dart';
import 'package:steamflix/app/widgets/bottomnavbar.dart';
import 'package:steamflix/app/widgets/searchlist.dart';
import 'package:unicons/unicons.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isVisible = true;
  bool isLoading = true;
  final ScrollController _scrollController = ScrollController();
  final myController = TextEditingController();
  String query = "";

  @override
  

  @override
  void dispose() {
    super.dispose();
    myController.dispose();
   
  }

  void hide() {
    if (isVisible) {
      setState(() {
        isVisible = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavBar(),
        resizeToAvoidBottomInset: false,
        backgroundColor: background_primary,
        
        extendBody: true,
        body: Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            Image.asset(
              'assets/backdrop.png',
              fit: BoxFit.fitWidth,
              width: size.width,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  margin: const EdgeInsets.fromLTRB(8, 28, 8, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: accent_t.withOpacity(0.95),
                  ),
                  child: TextField(
                    controller: myController,
                    cursorColor: accent_secondary,
                    maxLines: 1,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        UniconsLine.search,
                        color: Colors.white,
                      ),
                      prefixIconColor: Colors.white,
                    ),
                    onChanged: (value) {
                      setState(() {
                        query = myController.text;
                      });
                    },
                  ),
                ),
                SearchList(
                    future: APIService().getSearchResult(query),
                    scrollController: _scrollController),
              ],
            ),
            if (query == "")
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/No_data.json',
                      width: size.width * 0.60,
                      frameRate: FrameRate(60),
                    ),
                    Text(
                      'Search for your favorite movies and shows!',
                      style: TextStyle(
                        color: inactive_accent,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
