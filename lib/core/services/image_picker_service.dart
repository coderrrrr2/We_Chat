import 'dart:developer';

import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePickerService {
  // Function to pick an image from the gallery
  static Future<File?> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();

    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        return File(image.path);
      }
    } catch (e) {
      log('Error picking image from gallery: $e');
    }
    return null;
  }

  // Function to pick an image using the camera
  static Future<File?> pickImageFromCamera() async {
    try {
      final ImagePicker picker = ImagePicker();

      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        return File(image.path);
      }
    } catch (e) {
      log('Error picking image from camera: $e');
    }
    return null;
  }
}
