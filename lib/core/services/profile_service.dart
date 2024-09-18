import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:practice_chat_app/core/init/init_services.dart';
import 'package:practice_chat_app/models/user_model.dart';
import 'package:path/path.dart' as p;

class ProfileService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Stream<QuerySnapshot<UserProfile>> getUserProfile() {
    return usersCollection
        ?.where("uid", isEqualTo: authService.user!.uid)
        .snapshots() as Stream<QuerySnapshot<UserProfile>>;
  }

  Future<UserProfile?> getUserData(String uid) async {
    try {
      final querySnapshot =
          await usersCollection!.where('uid', isEqualTo: uid).get();

      if (querySnapshot.docs.isNotEmpty) {
        log("user data retrieved succesfully");
        final data = querySnapshot.docs.first.data() as UserProfile;
        log(data.toString());

        return data;
      } else {
        log('No user found with the given uid');
        return null;
      }
    } catch (e) {
      log('Error getting user data: $e');
      return null;
    }
  }

  Future<bool> updateUserData(UserProfile user, String oldpfpUrl) async {
    try {
      log(user.toString());
      log("update user data uid is ${user.uid}");
      await usersCollection?.doc(authService.user!.uid).update(user.toJson());
      log("user data updated succesfully");
      // if (oldpfpUrl.isNotEmpty) {
      //   await Future.delayed(Duration(seconds: 2));
      //   log("url that is deleted $oldpfpUrl");
      //   await deleteOldProfilePicture(oldpfpUrl);
      // }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String?> updateProfilePicture(
      {required File file, required String uid}) async {
    try {
      log("profile picture user is $uid");
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

  Future<bool> deleteOldProfilePicture(String imageUrl) async {
    try {
      final storageRef = _storage.refFromURL(imageUrl);

      await storageRef.delete();

      log('Old profile picture deleted successfully');
      return true;
    } catch (e) {
      log('Error deleting old profile picture: $e');
      return false;
    }
  }
}
