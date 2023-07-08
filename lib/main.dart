import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_movie_app/routes/navigator_service.dart';
import 'package:tmdb_movie_app/routes/route_generator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [ChuckerFlutter.navigatorObserver],
      onGenerateRoute: RouteGenerator.generateRoute,
      navigatorKey: NavigationService.instance.navigationKey,
    );
  }
}
