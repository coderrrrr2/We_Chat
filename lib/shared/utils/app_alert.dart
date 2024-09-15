import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:practice_chat_app/shared/utils/app_color.dart';

class AppAlert {
  // Show Toast
  static void showToast(BuildContext context,
      {required String message, IconData? icon}) {
    DelightToastBar(
      snackbarDuration: const Duration(seconds: 2),
      autoDismiss: true,
      position: DelightSnackbarPosition.top,
      builder: (context) {
        return ToastCard(
            leading: Icon(
              icon ?? Icons.error,
              size: 28,
              color: blackColor,
            ),
            title: Text(message));
      },
    ).show(context);
  }

  // Show SnackBar
  // static void showSnackBar(BuildContext context, String message,
  //     {Duration duration = const Duration(seconds: 3)}) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(message),
  //       duration: duration,
  //     ),
  //   );
  // }
}
