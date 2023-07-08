// ignore_for_file: library_private_types_in_public_api, lines_longer_than_80_chars, unnecessary_lambdas, cascade_invocations

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mobx/mobx.dart';
import 'package:tmdb_movie_app/api_service/repository.dart';
import 'package:tmdb_movie_app/debounce/debunce.dart';
import 'package:tmdb_movie_app/enum/network_status.dart';
import 'package:tmdb_movie_app/generics/respose_or_error_generics.dart';
import 'package:tmdb_movie_app/model/model.dart';
import 'package:tmdb_movie_app/model/tmdb_result_model.dart';

part 'home_page_store.g.dart';

class HomePageStore = _HomePageStore with _$HomePageStore;

abstract class _HomePageStore with Store {
  _HomePageStore() {
    debugPrint('Constructor is called');
    pagingController.addPageRequestListener(
      (pageKey) {
        getMovieList(pageKey);
      },
    );
  }

  final debouncer = Debouncer(second: 1);

  @observable
  Status appState = Status.init;

  @observable
  bool isSearchIconPress = false;

  TextEditingController searchController = TextEditingController();

  /// Paging controller will be called whenever it will be in Widget Tree..
  PagingController<int, TMDBModel> pagingController =
      PagingController(firstPageKey: 1);

  Future<void> getMovieList(int page) async {
    if (searchController.text.isNotEmpty) {
      final response = await Repository.instance
          .getSearchMovieResult(page, searchController.text);
      appendResponse(response);
    } else {
      final response = await Repository.instance.getMovieData(page);
      appendResponse(response);
    }

    debugPrint('Inside Get Movie List');
    // appState = Status.loading;
  }

  void appendResponse(ResponseOrError<TMDBResult> result) {
    if (result.response != null) {
      if ((pagingController.itemList?.length ?? 0) +
              result.response!.results.length >=
          result.response!.totalResults) {
        pagingController.appendLastPage(result.response!.results);
      } else {
        pagingController
          ..appendPage(
            result.response!.results,
            pagingController.nextPageKey,
          )
          ..nextPageKey = pagingController.nextPageKey! + 1;
      }
    } else {
      pagingController.error = result.errorInfo;
    }
  }

  void callAgainMovieList() {
    debouncer.cancelRequest();
    isSearchIconPress = !isSearchIconPress;
    searchController.clear();
    pagingController.nextPageKey = pagingController.firstPageKey;
    pagingController.itemList?.clear();
    getMovieList(pagingController.firstPageKey);
  }

  void isSearchIconPressed() {
    isSearchIconPress = !isSearchIconPress;
  }

  void onChangedValue(String value) {
    if (value.isNotEmpty) {
      pagingController.nextPageKey = pagingController.firstPageKey;
      pagingController.itemList?.clear();
      debouncer.run(
        () => getMovieList(pagingController.firstPageKey),
      );
    } else {
      pagingController.nextPageKey = pagingController.firstPageKey;
      pagingController.itemList?.clear();
      getMovieList(pagingController.firstPageKey);
    }
  }

  /// Custom Pagination
/*late ScrollController scrollController = ScrollController()
  ..addListener(loadMoreMovie);

void loadMoreMovie() {
  if (scrollController.offset >=
          scrollController.position.maxScrollExtent - 750 &&
      !isMoreDataLoading) {
    isMoreDataLoading = true;
    log('page is $pageNo');
    pageNo += 1;
    log('page is $pageNo');
    getMovieList(pageNo);
  }
}*/

  /// Check connectivity using ping any website and check response is true or not
/* Future<bool> checkInternetConnectivity() async {
    try {
      var internetResponse = await InternetAddress.lookup('www.google.com');
      if (internetResponse.isNotEmpty &&
          internetResponse[0].rawAddress.isNotEmpty) {
        debugPrint(internetResponse[0].rawAddress.toString());
        return true;
      } else {
        internetResponse = [];
      }
    } catch (e) {
      if (e is SocketException) {
        debugPrint('No Internet Connectivity');
      }
    }
    return false;
  }*/

  /// Get Movie List From TMDB
/*Future<void> getMovieList(int page, [String? title]) async {
    if (await checkInternetConnectivity()) {
      if (searchController.text.isNotEmpty) {
        final response =
            await Repository.instance.getSearchMovieResult(pageNo, title!);
        if (response.response != null) {
          if (response.response!.length >= 20) {
            pageNo++;
            pagingController.appendPage(response.response!, pageNo);
          } else {
            pagingController.appendLastPage(response.response!);
          }
        } else {
          pagingController.error = response.errorInfo;
          // errorMessage = response.errorInfo!;
        }
      } else {
        final response = await Repository.instance.getMovieData(page);
        if (response.response != null) {
          pageNo++;
          pagingController.appendPage(response.response!, pageNo);
          // appState = Status.success;
          // isMoreDataLoading = false;
        } else {
          pagingController.error = response.errorInfo;
          //errorMessage = response.errorInfo!;
          // appState = Status.failure;
        }
      }
    } else {
      pagingController.error = 'No Internet';
      debugPrint('No Internet Connection');
    }

    debugPrint('Inside Get Movie List');
    // appState = Status.loading;
  }*/

/* Future<void> getSearchResult(int page, String title) async {
    print('PAGE NUMBER :: $page');
    //appState = Status.loading;
    final response =
        await Repository.instance.getSearchMovieResult(page, title);

    if (response.response != null) {
      pageNo++;
      pagingController.appendPage(response.response!, pageNo);
      // appState = Status.success;
    } else {
      errorMessage = response.errorInfo!;
      // appState = Status.failure;
    }
  }*/

  /// For Multipart Request
  Future<void> sendImage() async {
    final imagePicker = ImagePicker();
    final pickImage = await imagePicker.pickImage(source: ImageSource.gallery);
    final file = File(pickImage!.path);

    final base64Image = base64Encode(await pickImage.readAsBytes());
    debugPrint('Convert to base64 and it will $base64Image');

    final decodeImage = base64Decode(base64Image);
    debugPrint('Decoded base64 Image is $decodeImage');

    // final formData = FormData.fromMap(
    //   {
    //     'file': await MultipartFile.fromFile(
    //       file.path,
    //       contentType: MediaType('image', 'jpeg'),
    //     ),
    //   },
    // );
    // try {
    //   final response = await SingletonDio.instance.newDio.post(
    //     'https://api.upload.io/v2/accounts/12a1yKs/uploads/form_data',
    //     data: formData,
    //   );
    //   if (response.statusCode == 200) {
    //     debugPrint('Image Uploaded');
    //   }
    // } catch (e, s) {
    //   debugPrintStack(stackTrace: s);
    //   debugPrint('Exception is $e');
    // }
  }
}
