import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:practice_chat_app/core/app_validator.dart';
import 'package:practice_chat_app/features/auth/presentation/routes/routes.dart';
import 'package:practice_chat_app/features/auth/viewmodel/auth_provider.dart';
import 'package:practice_chat_app/features/home/presentation/routes/routes.dart';
import 'package:practice_chat_app/features/navigation/app_navigator.dart';
import 'package:practice_chat_app/shared/utils/app_alert.dart';
import 'package:practice_chat_app/shared/widgets/app_button.dart';
import 'package:practice_chat_app/shared/widgets/app_column.dart';
import 'package:practice_chat_app/shared/widgets/app_textfield.dart';
import 'package:practice_chat_app/shared/shared_widgets.dart';
import 'package:practice_chat_app/shared/utils/text.dart';
import 'package:provider/provider.dart';

class PaswordlessLoginView extends StatefulWidget {
  const PaswordlessLoginView({super.key});

  @override
  State<PaswordlessLoginView> createState() => _PaswordlessLoginViewState();
}

class _PaswordlessLoginViewState extends State<PaswordlessLoginView> {
  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (_, vm, __) => Form(
        key: formKey,
        child: AppColumn(
          isLoading: vm.isLoading,
          children: [
            const LeadingText(text: "Hi, Welcome Back!"),
            const TrailingText(text: "Hello again,  you've been missed"),
            addHeight(30),
            AppTextField(
              controller: emailController,
              header: 'Email',
              validator: (p0) {
                return AppValidator.validateEmail(p0);
              },
            ),
            addHeight(30),
            AppButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    vm
                        .passwordLessLogin(
                      emailController.text,
                    )
                        .then((value) {
                      if (value) {
                        log("login is succesful");
                        AppNavigator.replaceAllRoutes(HomeRoutes.baseView);
                      } else {
                        AppAlert.showToast(context, message: vm.errorMessage);
                      }
                    });
                  }
                },
                text: 'Login'),
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
        ),
      ),
    );
  }
}
