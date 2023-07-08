import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobx/mobx.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tmdb_movie_app/abstract_dispose/dispose.dart';
import 'package:tmdb_movie_app/api_service/repository.dart';
import 'package:tmdb_movie_app/model/model.dart';
import 'package:tmdb_movie_app/model/video_model.dart';
import 'package:tmdb_movie_app/routes/navigator_service.dart';
import 'package:tmdb_movie_app/utils/strings.dart';
import 'package:url_launcher/url_launcher.dart';

part 'details_page_store.g.dart';

class DetailsPageStore = _DetailsPageStore with _$DetailsPageStore;

abstract class _DetailsPageStore with Store implements Disposable {
  _DetailsPageStore({required this.tmdbModel}) {
    getVideoList();
  }

  final TMDBModel tmdbModel;

  ObservableList<VideoModel> videoResult = ObservableList.of([]);

  @observable
  String? errorInfo;

  late final StreamSubscription<PermissionStatus> subscription;

  Future<String?> getVideoList() async {
    debugPrint('Function is called');
    final response =
        await Repository.instance.getMovieVideos(tmdbModel.id!, Strings.apiKey);

    if (response.response != null) {
      videoResult.addAll(response.response!.results);
    } else {
      errorInfo = response.errorInfo;
    }
    return response.response?.results[0].videoKey;
  }

  Future<void> getVideo() async {
    final key = await getVideoList();
    final url = Uri.parse('https://www.youtube.com/watch?v=$key');
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        );
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      debugPrint('Something went wrong');
    }
  }

  Future<void> getStoragePermission(String url, String movieName) async {
    if (Platform.isAndroid) {
      subscription = Permission.accessMediaLocation.status
          .asStream()
          .listen((status) async {
        if (status.isGranted) {
          await downloadImage(url, movieName);
        } else {
          if (status.isDenied) {
            if (await Permission.accessMediaLocation.request().isGranted) {
              await downloadImage(url, movieName);
            }
          } else if (status.isPermanentlyDenied) {
            await openAppSettings();
          }
        }
      });
    }
  }

  // Future<void> getStoragePermission(String url, String movieName) async {
  //   if (Platform.isAndroid) {
  //     final status = await Permission.accessMediaLocation.request();
  //
  //     if (status.isGranted) {
  //       await downloadImage(url, movieName);
  //     } else {
  //       if (status.isDenied) {
  //         if (await Permission.accessMediaLocation.request().isGranted) {
  //           await downloadImage(url, movieName);
  //         }
  //       } else if (status.isPermanentlyDenied) {
  //         await openAppSettings();
  //       }
  //     }
  //   } else {
  //     final iosStatus = await Permission.photos.request();
  //
  //     if (iosStatus.isGranted) {
  //       await downloadImage(url, movieName);
  //     } else {
  //       if (iosStatus.isDenied) {
  //         if (await Permission.accessMediaLocation.request().isGranted) {
  //           await downloadImage(url, movieName);
  //         }
  //       } else if (iosStatus.isPermanentlyDenied) {
  //         await openAppSettings();
  //       }
  //     }
  //   }
  // }

  Future<void> downloadImage(String url, String movieName) async {
    final response = await http.get(Uri.parse(url));

    // final directory = await getApplicationDocumentsDirectory();
    // debugPrint('directory is $directory');

    /*final tempDirectory = await getTemporaryDirectory();
    debugPrint('temp directory is $tempDirectory');

    final supportDirectory = await getApplicationSupportDirectory();
    debugPrint('support directory is $supportDirectory');
    final downloadDirectory = await getDownloadsDirectory();
    debugPrint('download directory is $downloadDirectory');
    final libraryDirectory = await getLibraryDirectory();
    debugPrint('library directory is $libraryDirectory');*/
    final externalDirectory = await getExternalStorageDirectory();
    debugPrint('external directory is $externalDirectory');

    final imageName = movieName + path.extension(url);
    final localPath = path.join(externalDirectory!.path, imageName);
    debugPrint('local path is $localPath');
    final imageFile = File(localPath);
    await imageFile.writeAsBytes(response.bodyBytes);
    ScaffoldMessenger.of(NavigationService.instance.context).showSnackBar(
      SnackBar(content: Text('Successfully download $movieName image')),
    );
  }

  @override
  void dispose() {
    subscription.cancel();
  }
}
