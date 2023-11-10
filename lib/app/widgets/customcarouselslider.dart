// ignore_for_file: library_private_types_in_public_api
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:steamflix/app/models/TvShow.dart';
import 'package:steamflix/app/widgets/landingcard.dart';

class CustomCarouselSlider extends StatefulWidget {
  final List<TvShow> data;

  const CustomCarouselSlider({Key? key, required this.data}) : super(key: key);

  @override
  _CustomCarouselSliderState createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  late final PageController _pageController;
  late Timer _timer; // Store a reference to the timer
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    startAutoScroll();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentPage < widget.data.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: (size.height * 0.33 < 300) ? 300 : size.height * 0.33,
      child: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        pageSnapping: true,
        itemCount: widget.data.length,
        itemBuilder: (context, index) {
          var url = widget.data[index].backdropPath.toString();
          return GestureDetector(
            onTap: () {
              HapticFeedback.mediumImpact();
              Get.toNamed('/tv/${widget.data[index].id}');
            },
            child: LandingCard(
              image: CachedNetworkImageProvider(
                "https://image.tmdb.org/t/p/original$url",
              ),
              name: widget.data[index].name.toString(),
            ),
          );
        },
      ),
    );
  }
}