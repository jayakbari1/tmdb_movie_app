import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_movie_app/enum/network_status.dart';
import 'package:tmdb_movie_app/model/model.dart';
import 'package:tmdb_movie_app/pages/pageview/items_list_view.dart';
import 'package:tmdb_movie_app/store/home_page_store.dart';

class MovieListView extends StatelessWidget {
  const MovieListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final store = context.read<HomePageStore>();
    return PagedListView(
      pagingController: store.pagingController,
      builderDelegate: PagedChildBuilderDelegate(
        itemBuilder: (_, TMDBModel item, __) {
          return ItemsOfListView(tmdbModel: item);
        },
        firstPageProgressIndicatorBuilder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        newPageProgressIndicatorBuilder: (_) {
          if (store.appState == Status.failure) {
            debugPrint('Inside If');
            return Center(
              child: ElevatedButton(
                onPressed: store.pagingController.retryLastFailedRequest,
                child: const Text('Retry'),
              ),
            );
          } else {
            debugPrint('Inside Else');
            return const Padding(
              padding: EdgeInsets.all(8),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
