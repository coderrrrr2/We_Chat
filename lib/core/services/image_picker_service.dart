import 'dart:developer';

import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  // Function to pick an image from the gallery
  Future<File?> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        return File(image.path);
      }
    } catch (e) {
      log('Error picking image from gallery: $e');
    }
    return null;
  }

  // Function to pick an image using the camera
  Future<File?> pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        return File(image.path);
      }
    } catch (e) {
      log('Error picking image from camera: $e');
    }
    return null;
  }
}
