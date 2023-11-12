import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:steamflix/app/models/article_model.dart';
import 'package:steamflix/app/utils/consts.dart';
import 'package:steamflix/app/views/news/details_screen.dart';

class NewsCard extends StatelessWidget {
  final Article article;

  const NewsCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(color:  background_primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: article.urlToImage.toString(),
            height: 160,
            width: double.infinity,
            fit: BoxFit.cover,
            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  article.title,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                Container(height: 10),
                Text(
                  article.description.toString(),
                  maxLines: 6,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                Row(
                  children: <Widget>[
                    const Spacer(),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.transparent,
                      ),
                      child: const Text(
                        "",
                        style: TextStyle(color: Colors.amber),
                      ),
                      onPressed: () {},
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.transparent,
                      ),
                      child: const Text(
                        "VIEW MORE",
                        style: TextStyle(color: Colors.amber),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                NewsDetailsScreen(article: article),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(height: 5),
        ],
      ),
    );
  }
}
