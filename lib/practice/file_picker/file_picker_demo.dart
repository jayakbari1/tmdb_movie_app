import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_movie_app/practice/store/file_picker_store.dart';

class FilePickerDemo extends StatelessWidget {
  const FilePickerDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.read<FilePickerStore>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick File'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Observer(
              builder: (_) {
                if (store.result != null) {
                  if (store.filePickerStatus == FilePickerStatus.picking) {
                    return const CircularProgressIndicator();
                  } else {
                    return SizedBox.square(
                      dimension: 200,
                      child: store.file?.extension == 'mp4'
                          ? const Center(child: Text('You Select Video'))
                          : Image.file(
                              File(store.result?.paths.first ?? ''),
                            ),
                    );
                  }
                } else {
                  return const Text('No Image Selected');
                }
              },
            ),
            ElevatedButton(
              onPressed: store.pickFile,
              child: const Text('Pick File'),
            ),
          ],
        ),
      ),
    );
  }
}
