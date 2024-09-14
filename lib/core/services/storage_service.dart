import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  Future<String?> uploadUserProfilePicture(
      {required File file, required String uid}) async {
    try {
      Reference fileRef =
          _storage.ref('users/pfps').child('$uid${p.extension(file.path)}');
      UploadTask task = fileRef.putFile(file);
      return task.then(
        // ignore: body_might_complete_normally_nullable
        (p) {
          if (p.state == TaskState.success) {
            return fileRef.getDownloadURL();
          } else if (p.state == TaskState.error) {
            throw Exception();
          }
        },
      );
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<String?> uploadChatImage(
      {required File file, required String chatId}) async {
    try {
      Reference fileRef = _storage.ref('chats/$chatId').child(
          '${DateTime.now().toIso8601String()}${p.extension(file.path)}');
      UploadTask task = fileRef.putFile(file);
      return task.then(
        // ignore: body_might_complete_normally_nullable
        (p) {
          if (p.state == TaskState.success) {
            return fileRef.getDownloadURL();
          } else if (p.state == TaskState.error) {
            throw Exception();
          }
        },
      );
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
