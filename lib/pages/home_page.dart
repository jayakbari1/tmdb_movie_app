import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_movie_app/routes/navigator_service.dart';
import 'package:tmdb_movie_app/routes/routes.dart';
import 'package:tmdb_movie_app/store/home_page_store.dart';
import 'package:tmdb_movie_app/widgets/movie_list_grid_view.dart';
import 'package:tmdb_movie_app/widgets/show_title_or_textfield.dart';

class HomePage extends StatelessObserverWidget {
  const HomePage({super.key});

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
              onPressed: store.isSearchIconPressed,
              icon: const Icon(Icons.search_outlined),
            )
          else
            IconButton(
              onPressed: store.callAgainMovieList,
              icon: const Icon(Icons.cancel),
            ),
        ],
      ),
      body: const MovieListGridView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            NavigationService.instance.navigateToScreen(Routes.packageDemo),
        child: const Icon(Icons.image),
      ),

      // const SwitchCase(
      //   paginationWidget: MovieListGridView(),
      //   shimmerWidget: ShimmerGridView(),
      // ),

      // Observer(
      //   builder: (_) {
      //     switch (store.appState) {
      //       case Status.init:
      //         return const SizedBox.shrink();
      //       case Status.loading:
      //         if (store.pageNo == 1) {
      //           return const ShimmerGridView();
      //         }
      //         return const MovieListGridView();
      //       case Status.success:
      //         return const MovieListGridView();
      //
      //       case Status.failure:
      //         if (store.pageNo == 1) {
      //           return const MovieErrorWidget();
      //         } else {
      //           return const MovieListGridView();
      //         }
      //     }
      //   },
      // ),
    );
  }
}
