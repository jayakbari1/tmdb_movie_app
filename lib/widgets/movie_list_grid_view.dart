// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_movie_app/model/model.dart';
import 'package:tmdb_movie_app/store/home_page_store.dart';
import 'package:tmdb_movie_app/widgets/error_widget.dart';
import 'package:tmdb_movie_app/widgets/items_of_grid_view.dart';
import 'package:tmdb_movie_app/widgets/shimmer_grid_view.dart';

class MovieListGridView extends StatelessWidget {
  const MovieListGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.read<HomePageStore>();

    return PagedGridView(
      pagingController: store.pagingController,
      shrinkWrap: true,
      showNewPageErrorIndicatorAsGridChild: false,
      showNewPageProgressIndicatorAsGridChild: false,
      showNoMoreItemsIndicatorAsGridChild: false,
      builderDelegate: PagedChildBuilderDelegate(
        itemBuilder: (_, TMDBModel model, __) {
          return ItemsOfGridView(movieModel: model);
        },
        firstPageProgressIndicatorBuilder: (_) {
          debugPrint('Inside First Page Progress Indicator Builder');
          return const ShimmerGridView();
        },
        noMoreItemsIndicatorBuilder: (_) {
          debugPrint('Inside No More Items Indicator Builder');
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Center(
              child: Text(
                'No More Movies Found',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
        noItemsFoundIndicatorBuilder: (_) {
          debugPrint('Inside No Items Found Indicator Builder');
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Center(
              child: Text(
                'No movies',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
        firstPageErrorIndicatorBuilder: (_) => const MovieErrorWidget(),
        newPageErrorIndicatorBuilder: (_) {
          debugPrint('Inside New Page Error Indicator Builder');
          return Center(
            child: ElevatedButton(
              onPressed: store.pagingController.retryLastFailedRequest,
              child: const Text('Retry'),
            ),
          );
        },
        newPageProgressIndicatorBuilder: (_) {
          debugPrint('Inside New Page Progress Indicator Builder');
          return const Padding(
            padding: EdgeInsets.all(8),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 368,
      ),
    );
  }
}

// return GridView.builder(
//   addAutomaticKeepAlives: false,
//   controller: store.scrollController,
//   padding: EdgeInsets.zero,
//   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//     crossAxisCount: 2,
//     mainAxisExtent: 368,
//   ),
//   shrinkWrap: true,
//   itemCount: store.movieList.length + (store.isMoreDataLoading ? 1 : 0),
//   itemBuilder: (_, index) {
//     if (index == store.movieList.length) {
//       debugPrint('State is ${store.appState}');
//
//       return Center(
//         child: store.appState == Status.failure
//             ? ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.redAccent,
//                 ),
//                 onPressed: () => store.getMovieList(store.page),
//                 child: const Text('Retry'),
//               )
//             : const CircularProgressIndicator(),
//       );
//     }
//     return ItemsOfGridView(index: index);
//   },
// );

//
// return CustomScrollView(
//   controller: store.scrollController,
//   slivers: [
//     SliverGrid(
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         mainAxisExtent: 368,
//       ),
//       delegate: SliverChildBuilderDelegate(
//         (_, index) {
//           return ItemsOfGridView(index: index);
//         },
//         childCount: store.movieList.length,
//       ),
//     ),
//     SliverList(
//       delegate: SliverChildBuilderDelegate(
//         childCount: 1,
//         (context, index) {
//           if (store.appState == Status.failure) {
//             debugPrint('Inside IF');
//             return Center(
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.redAccent,
//                 ),
//                 onPressed: () => store.getMovieList(store.pageNo),
//                 child: const Text('Retry'),
//               ),
//             );
//           } else {
//             debugPrint('Inside ELSE');
//             return const Padding(
//               padding: EdgeInsets.all(8),
//               child: SizedBox.square(
//                 dimension: 30,
//                 child: Center(
//                   child: CircularProgressIndicator(),
//                 ),
//               ),
//             );
//           }
//         },
//       ),
//     ),
//   ],
// );
