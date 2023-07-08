import 'package:flutter/material.dart';
import 'package:tmdb_movie_app/extensions/provider_extension.dart';
import 'package:tmdb_movie_app/practice/file_picker/file_picker_demo.dart';
import 'package:tmdb_movie_app/practice/store/file_picker_store.dart';
import 'package:tmdb_movie_app/practice/url_launcher/url_launcher_demo.dart';

class PackageDemo extends StatelessWidget {
  const PackageDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TMDB API CALL'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<Widget>(
                    builder: (_) => const UrlLauncherDemo(),
                  ),
                );
                /*Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const UrlLauncherDemo(),
                ),
              );*/
              },
              child: const Text('URL Launcher Demo'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<Widget>(
                    builder: (_) => const FilePickerDemo().withProvider(
                      FilePickerStore(),
                    ),
                  ),
                );
                /*Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const UrlLauncherDemo(),
                ),
              );*/
              },
              child: const Text('File Picker'),
            ),
          ],
        ),
      ),
    );
  }
}
