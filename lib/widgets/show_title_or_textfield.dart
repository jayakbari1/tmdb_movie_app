import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_movie_app/store/home_page_store.dart';

class ShowTitleOrTextField extends StatelessObserverWidget {
  const ShowTitleOrTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.read<HomePageStore>();
    return !store.isSearchIconPress
        ? const Text('Home Page')
        : Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              height: 50,
              child: TextField(
                controller: store.searchController,
                onChanged: store.onChangedValue,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          );
  }
}
