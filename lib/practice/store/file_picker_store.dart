import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

part 'file_picker_store.g.dart';

class FilePickerStore = _FilePickerStore with _$FilePickerStore;

abstract class _FilePickerStore with Store {
  @observable
  FilePickerResult? result;

  @observable
  FilePickerStatus? filePickerStatus;

  @observable
  PlatformFile? file;

  Future<void> pickFile() async {
    result = await FilePicker.platform.pickFiles(
      // allowedExtensions: ['jpg', 'png'],
      // allowMultiple: true

      type: FileType.custom,
    );
    file = result!.files.first;
    debugPrint(file?.extension);
    debugPrint(file?.name);
    debugPrint(file?.identifier);
    if (kDebugMode) {
      print(file?.size);
    }
    debugPrint('result is $result');
  }
}
