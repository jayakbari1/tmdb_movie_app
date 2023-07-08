import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_movie_app/model/model.dart';
import 'package:tmdb_movie_app/routes/navigator_service.dart';
import 'package:tmdb_movie_app/store/details_page_store.dart';
import 'package:tmdb_movie_app/utils/strings.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({
    required this.tmdbModel,
    super.key,
  });

  final TMDBModel tmdbModel;

  @override
  Widget build(BuildContext context) {
    final store = context.read<DetailsPageStore>();
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            child: CachedNetworkImage(
              imageUrl: Strings.imagePath + tmdbModel.posterPath!,
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
          ShaderMask(
            shaderCallback: (rect) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.white.withOpacity(0),
                  Colors.white.withOpacity(0),
                ],
                stops: const [
                  0.3,
                  0.6,
                  0.0,
                ],
              ).createShader(rect);
            },
            blendMode: BlendMode.dstOut,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black,
                    Colors.black87,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 20,
            child: IconButton(
              onPressed: NavigationService.instance.goBack,
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          Positioned(
            top: 50,
            right: 20,
            child: IconButton(
              onPressed: () => store.getStoragePermission(
                Strings.imagePath + tmdbModel.posterPath!,
                tmdbModel.title,
              ),
              icon: const Icon(
                Icons.cloud_download,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        height: 30,
                        width: 110,
                        decoration: BoxDecoration(
                          color: Colors.yellowAccent.shade700,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            tmdbModel.releaseDate,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.star,
                        color: Colors.black,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellowAccent.shade700,
                      ),
                      label: Text(
                        tmdbModel.voteAverage.toString(),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.group,
                        color: Colors.black,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellowAccent.shade700,
                      ),
                      label: Text(
                        tmdbModel.voteCount.toString(),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      tmdbModel.title,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white60,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      tmdbModel.overview,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: store.getVideo,
                  child: const Text('Watch Trailer'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
