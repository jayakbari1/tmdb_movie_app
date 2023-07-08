import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_movie_app/model/model.dart';
import 'package:tmdb_movie_app/routes/navigator_service.dart';
import 'package:tmdb_movie_app/routes/routes.dart';
import 'package:tmdb_movie_app/utils/strings.dart';

class ItemsOfGridView extends StatelessWidget {
  const ItemsOfGridView({
    required this.movieModel,
    super.key,
  });

  final TMDBModel movieModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => NavigationService.instance.navigateToScreen(
        Routes.detailsPage,
        arguments: movieModel,
      ),
      child: SizedBox(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(
              color: Colors.redAccent.withOpacity(0.7),
              width: 5,
            ),
          ),
          child: SizedBox(
            child: CachedNetworkImage(
              imageUrl: movieModel.id == 1
                  ? movieModel.posterPath!
                  : Strings.imagePath + movieModel.posterPath!,
              placeholder: (_, __) => SizedBox.fromSize(
                size: const Size.fromHeight(368),
                child: Image.asset(
                  Strings.imagePlaceHolder,
                  fit: BoxFit.cover,
                ),
              ),
              errorWidget: (_, __, ___) {
                return Container(
                  height: 200,
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
        ),
      ),
    );
  }
}
