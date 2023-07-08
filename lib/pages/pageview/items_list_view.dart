import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_movie_app/model/model.dart';
import 'package:tmdb_movie_app/routes/navigator_service.dart';
import 'package:tmdb_movie_app/routes/routes.dart';
import 'package:tmdb_movie_app/utils/strings.dart';

class ItemsOfListView extends StatelessWidget {
  const ItemsOfListView({
    required this.tmdbModel,
    super.key,
  });
  final TMDBModel tmdbModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => NavigationService.instance.navigateToScreen(
        Routes.detailsPage,
        arguments: tmdbModel,
      ),
      child: Row(
        children: [
          SizedBox.square(
            dimension: 200,
            child: CachedNetworkImage(
              imageUrl: Strings.imagePath + tmdbModel.posterPath!,
              placeholder: (_, __) => SizedBox(
                child: Image.asset(
                  Strings.imagePlaceHolder,
                  fit: BoxFit.fill,
                ),
              ),
              errorWidget: (_, __, ___) {
                return Container(
                  height: 400,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        Strings.imageNotFound,
                      ),
                    ),
                  ),
                );
              },
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tmdbModel.title,
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  tmdbModel.releaseDate,
                  style: const TextStyle(color: Colors.red, fontSize: 15),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
