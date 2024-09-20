import 'package:flutter/material.dart';
import 'package:practice_chat_app/features/auth/presentation/routes/routes.dart';
import 'package:practice_chat_app/features/navigation/app_navigator.dart';
import 'package:practice_chat_app/shared/shared_widgets.dart';
import 'package:practice_chat_app/shared/utils/app_color.dart';
import 'package:practice_chat_app/shared/utils/text.dart';
import 'package:practice_chat_app/shared/widgets/app_column.dart';

class ChooseLoginTypeView extends StatefulWidget {
  const ChooseLoginTypeView({super.key});

  @override
  State<ChooseLoginTypeView> createState() => _ChooseLoginTypeViewState();
}

class _ChooseLoginTypeViewState extends State<ChooseLoginTypeView> {
  @override
  Widget build(BuildContext context) {
    return AppColumn(
      children: [
        const LeadingText(text: "Let's, get going!"),
        const TrailingText(text: "Choose your Login Type"),
        addHeight(150),
        _buildLoginButton(() {
          AppNavigator.pushRoute(AuthRoutes.loginWithEmailAndPassword);
        }, 'Email', Icons.email),
        addHeight(30),
        _buildLoginButton(() {
          AppNavigator.pushRoute(AuthRoutes.passwordLessLogin);
        }, 'Passwordless', Icons.link),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Don\'t have an account?'),
            TextButton(
              onPressed: () {
                AppNavigator.pushRoute(AuthRoutes.register);
              },
              child: const Text('Sign Up'),
            ),
            addHeight(60),
          ],
        ),
      ],
    );
  }

  Widget _buildLoginButton(VoidCallback ontap, String text, IconData icon) {
    return ElevatedButton(
        onPressed: ontap,
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(600, 60),
            backgroundColor: whiteColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(color: extraLightGreyColor, width: 1))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: blackColor),
            addWidth(10),
            AppText(text: text),
          ],
        ));
  }
}
