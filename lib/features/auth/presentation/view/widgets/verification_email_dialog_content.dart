import 'package:flutter/material.dart';
import 'package:practice_chat_app/shared/shared_widgets.dart';
import 'package:practice_chat_app/shared/utils/text.dart';

class VerificationEmailDialogContent extends StatelessWidget {
  final VoidCallback onDimssed;
  final bool isLoggedIn;
  const VerificationEmailDialogContent(
      {super.key, required this.onDimssed, this.isLoggedIn = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Spacer(),
              IconButton(
                onPressed: onDimssed,
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const Icon(Icons.email, size: 100),
          addHeight(10),
          if (isLoggedIn)
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const AppText(text: "Your Email hasn't been verified"),
                addHeight(10),
                AppText(
                    textAlign: TextAlign.center,
                    text:
                        "Please verify your email to\ncontinue using this application"),
                addHeight(30),
              ],
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const AppText(text: "An Email has been sent to your Inbox"),
                addHeight(10),
                const Text("Please verify your email to continue"),
                addHeight(30),
              ],
            )
        ],
      ),
    );
  }
}
