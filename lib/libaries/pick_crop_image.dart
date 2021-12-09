import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class PickCropImage{
  static Future<File?> pickMedia({ ImageSource? source, required Future<File?> Function(File file) cropImage }) async {
    final imageSource = (source != null) ? source : ImageSource.gallery;
    final picker = ImagePicker();
    var pickedFile = await picker.pickImage(source: imageSource);
    if(pickedFile == null){
      return null;
    }

    if(cropImage == null){
      return File(pickedFile.path);
    }else{
      final file = File(pickedFile.path);

      return cropImage(file);
    }

  }

  static Future<File?> cropSquareImage(File imageFile) async {
    return await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        aspectRatioPresets: Platform.isAndroid
        ? [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
        ]
        : [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio5x3,
        CropAspectRatioPreset.ratio5x4,
        CropAspectRatioPreset.ratio7x5,
        CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        )
    );
  }

  static Future<File?> getFile({ImageSource? source}){
    return pickMedia(cropImage: cropSquareImage);
  }
}