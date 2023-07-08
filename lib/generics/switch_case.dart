import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_movie_app/enum/network_status.dart';
import 'package:tmdb_movie_app/store/home_page_store.dart';
import 'package:tmdb_movie_app/widgets/error_widget.dart';

class SwitchCase extends StatelessWidget {
  const SwitchCase({
    required this.shimmerWidget,
    required this.paginationWidget,
    super.key,
  });

  final Widget shimmerWidget;
  final Widget paginationWidget;

  @override
  Widget build(BuildContext context) {
    final store = context.read<HomePageStore>();
    return Observer(
      builder: (_) {
        switch (store.appState) {
          case Status.init:
            return const SizedBox.shrink();
          case Status.loading:
            if (store.pagingController.firstPageKey == 1) {
              return shimmerWidget;
            }
            return paginationWidget;
          case Status.success:
            return paginationWidget;

          case Status.failure:
            if (store.pagingController.firstPageKey == 1) {
              return const MovieErrorWidget();
            } else {
              return paginationWidget;
            }
        }
      },
    );
  }
}
