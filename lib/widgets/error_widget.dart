import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_movie_app/store/home_page_store.dart';

class MovieErrorWidget extends StatelessWidget {
  const MovieErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.read<HomePageStore>();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            store.pagingController.error.toString(),
            style: const TextStyle(color: Colors.white70),
          ),
          ElevatedButton(
            onPressed: store.pagingController.retryLastFailedRequest,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
