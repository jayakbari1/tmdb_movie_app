import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_movie_app/generics/switch_case.dart';
import 'package:tmdb_movie_app/pages/pageview/page_list_view.dart';
import 'package:tmdb_movie_app/pages/pageview/shimmer_list_view.dart';
import 'package:tmdb_movie_app/store/home_page_store.dart';
import 'package:tmdb_movie_app/widgets/show_title_or_textfield.dart';

class MoviePageView extends StatelessWidget {
  const MoviePageView({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.read<HomePageStore>();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: const ShowTitleOrTextField(),
        actions: [
          if (!store.isSearchIconPress)
            IconButton(
              onPressed: () {
                store.isSearchIconPress = !store.isSearchIconPress;
                store.searchController.clear();
              },
              icon: const Icon(Icons.search_outlined),
            )
          else
            IconButton(
              onPressed: store.callAgainMovieList,
              icon: const Icon(Icons.cancel),
            ),
        ],
      ),
      body: const SwitchCase(
        paginationWidget: MovieListView(),
        shimmerWidget: ShimmerOfListView(),
      ),
    );
  }
}
