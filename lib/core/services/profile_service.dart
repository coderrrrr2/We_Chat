import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practice_chat_app/core/init/init_services.dart';
import 'package:practice_chat_app/models/user_model.dart';

class ProfileService {
  Stream<QuerySnapshot<UserProfile>> getUserProfile() {
    log(authService.user!.uid);
    return usersCollection
        ?.where("uid", isEqualTo: authService.user!.uid)
        .snapshots() as Stream<QuerySnapshot<UserProfile>>;
  }

  Future<bool> updateUserName(String name) async {
    try {
      await usersCollection?.doc(authService.user!.uid).update({"name": name});
      return true;
    } catch (e) {
      return false;
    }
  }
}
