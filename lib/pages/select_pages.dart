import 'package:flutter/material.dart';
import 'package:tmdb_movie_app/routes/navigator_service.dart';
import 'package:tmdb_movie_app/routes/routes.dart';

class SelectPages extends StatelessWidget {
  const SelectPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Types of PageView'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                NavigationService.instance.navigateToScreen(Routes.pageView);
              },
              child: const Text('Page View'),
            ),
            ElevatedButton(
              onPressed: () {
                NavigationService.instance.navigateToScreen(Routes.gridView);
              },
              child: const Text('Grid View'),
            ),
            ElevatedButton(
              onPressed: () {
                NavigationService.instance
                    .navigateToScreen(Routes.sliverPageView);
              },
              child: const Text('Scrollable Sliver Page View'),
            ),
            ElevatedButton(
              onPressed: () {
                NavigationService.instance
                    .navigateToScreen(Routes.sliverGridView);
              },
              child: const Text('Scrollable Sliver Grid View'),
            )
          ],
        ),
      ),
    );
  }
}
