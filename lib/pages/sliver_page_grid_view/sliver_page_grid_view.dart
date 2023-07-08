import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_movie_app/enum/network_status.dart';
import 'package:tmdb_movie_app/model/model.dart';
import 'package:tmdb_movie_app/store/home_page_store.dart';
import 'package:tmdb_movie_app/widgets/items_of_grid_view.dart';
import 'package:tmdb_movie_app/widgets/shimmer_grid_view.dart';

class SliverPageGridView extends StatelessWidget {
  const SliverPageGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.read<HomePageStore>();
    return CustomScrollView(
      shrinkWrap: true,
      slivers: [
        PagedSliverGrid(
          showNewPageProgressIndicatorAsGridChild: false,
          pagingController: store.pagingController,
          builderDelegate: PagedChildBuilderDelegate(
            itemBuilder: (_, TMDBModel tmdbModel, __) {
              return ItemsOfGridView(
                movieModel: tmdbModel,
              );
            },
            firstPageProgressIndicatorBuilder: (context) {
              return const ShimmerGridView();
            },
            newPageProgressIndicatorBuilder: (context) {
              debugPrint(
                  'Error Occur and Circular  Indicator will be rendered');
              return Observer(
                builder: (context) {
                  if (store.appState == Status.failure) {
                    debugPrint('Inside If');
                    return Center(
                      child: ElevatedButton(
                        onPressed: () =>
                            store.pagingController.retryLastFailedRequest(),
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
              );
            },
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 368,
          ),
        ),
      ],
    );
  }
}
