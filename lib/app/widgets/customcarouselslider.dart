import 'package:cached_network_image/cached_network_image.dart';
 
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:steamflix/app/models/TvShow.dart';
import 'package:steamflix/app/widgets/landingcard.dart';


class CustomCarouselSlider extends StatelessWidget {
  final List<TvShow> data;
  const CustomCarouselSlider({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: (size.height * 0.33 < 300) ? 300 : size.height * 0.33,
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        pageSnapping: true,
        itemCount: 20,
        itemBuilder: (context, index) {
          var url = data[index].backdropPath.toString();
          return GestureDetector(
            onTap: () {
              HapticFeedback.mediumImpact();
              Get.toNamed('/tv/${data[index].id}');
            },
            child: LandingCard(
              image: CachedNetworkImageProvider(
                "https://image.tmdb.org/t/p/original$url",
              ),
              name: data[index].name.toString(),
            ),
          );
        },
      ),
    );
  }
}
