import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

enum ImagePicker {
  noStoragePermission,
  noStoragePermissionPermanent,
  browseFiles,
  imageLoaded,
}

class PicModel extends ChangeNotifier {
  ImagePicker _imagePicker = ImagePicker.browseFiles;

  ImagePicker get picSection => _imagePicker;

  set picSection(ImagePicker value) {
    if (value != _imagePicker) {
      _imagePicker = value;
      notifyListeners();
    }
  }

  File? file;

  Future<bool> requestFilePermission() async {
    PermissionStatus result;

    if (Platform.isAndroid) {
      result = await Permission.storage.request();
    } else {
      result = await Permission.photos.request();
    }

    if (result.isGranted) {
      picSection = ImagePicker.browseFiles;
      return true;
    } else if (Platform.isIOS || result.isPermanentlyDenied) {
      picSection = ImagePicker.noStoragePermissionPermanent;
    } else {
      picSection = ImagePicker.noStoragePermission;
    }
    return false;
  }


  Future<void> pickFile() async {
    final FilePickerResult? result =
    await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null &&
        result.files.isNotEmpty &&
        result.files.single.path != null) {
      file = File(result.files.single.path!);
      picSection = ImagePicker.imageLoaded;
    }
  }
}