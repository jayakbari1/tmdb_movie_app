// ignore_for_file: cast_nullable_to_non_nullable

import 'package:flutter/material.dart';
import 'package:tmdb_movie_app/extensions/provider_extension.dart';
import 'package:tmdb_movie_app/model/model.dart';
import 'package:tmdb_movie_app/pages/details_page.dart';
import 'package:tmdb_movie_app/pages/home_page.dart';
import 'package:tmdb_movie_app/pages/pageview/page_view.dart';
import 'package:tmdb_movie_app/pages/select_pages.dart';
import 'package:tmdb_movie_app/pages/sliver_page_grid_view/sliver_grid_page.dart';
import 'package:tmdb_movie_app/pages/sliver_page_view/sliver_page.dart';
import 'package:tmdb_movie_app/practice/package_demo_page.dart';
import 'package:tmdb_movie_app/routes/routes.dart';
import 'package:tmdb_movie_app/store/details_page_store.dart';
import 'package:tmdb_movie_app/store/home_page_store.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const SelectPages(),
        );
      case Routes.gridView:
        return MaterialPageRoute(
          builder: (_) => const HomePage().withProvider(HomePageStore()),
        );
      case Routes.pageView:
        return MaterialPageRoute(
          builder: (_) => const MoviePageView().withProvider(HomePageStore()),
        );
      case Routes.sliverPageView:
        return MaterialPageRoute(
          builder: (_) => const SliverMoviePageList().withProvider(
            HomePageStore(),
          ),
        );
      case Routes.sliverGridView:
        return MaterialPageRoute(
          builder: (_) => const SliverMoviePageGrid().withProvider(
            HomePageStore(),
          ),
        );
      case Routes.detailsPage:
        return MaterialPageRoute(
          builder: (_) => DetailsPage(
            tmdbModel: args as TMDBModel,
          ).withProvider(DetailsPageStore(tmdbModel: args)),
        );
      case Routes.packageDemo:
        return MaterialPageRoute(
          builder: (_) => const PackageDemo(),
        );

      default:
        return errorRoute();
    }
  }

  static Route<dynamic> errorRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Error',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          body: const Center(
            child: Text('No Routes Found'),
          ),
        );
      },
    );
  }
}
