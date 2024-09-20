import 'package:flutter/material.dart';
import 'package:practice_chat_app/shared/utils/app_color.dart';

class AppDialog {
  static Future<bool?> showCustomDialog(
    Widget content, {
    required BuildContext context,
  }) async {
    return await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => Dialog(
              child: Container(
                  decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: content),
            ));
  }
}
