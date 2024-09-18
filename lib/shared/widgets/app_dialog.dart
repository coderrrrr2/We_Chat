import 'package:flutter/material.dart';
import 'package:practice_chat_app/shared/utils/app_color.dart';

class AppDialog {
  static void showCustomDialog(Widget content,
      {required BuildContext context}) async {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => Container(
            decoration: BoxDecoration(
                color: whiteColor, borderRadius: BorderRadius.circular(10)),
            child: content));
  }
}
