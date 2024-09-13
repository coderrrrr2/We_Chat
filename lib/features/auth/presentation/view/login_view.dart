import 'package:flutter/material.dart';
import 'package:practice_chat_app/core/app_validator.dart';
import 'package:practice_chat_app/core/services/auth_service.dart';
import 'package:practice_chat_app/features/auth/presentation/routes/routes.dart';
import 'package:practice_chat_app/features/home/presentation/routes/routes.dart';
import 'package:practice_chat_app/features/navigation/app_navigator.dart';
import 'package:practice_chat_app/shared/app_button.dart';
import 'package:practice_chat_app/shared/app_textfield.dart';
import 'package:practice_chat_app/shared/shared_widgets.dart';
import 'package:practice_chat_app/shared/text.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: formKey,
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                AppTextField(
                  controller: passwordController,
                  header: 'Password',
                  validator: (p0) {
                    return AppValidator.validatePassword(p0);
                  },
                ),
                addHeight(30),
                AppButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        AuthService()
                            .login(
                                emailController.text, passwordController.text)
                            .then((value) {
                          if (value) {
                            AppNavigator.pushRoute(HomeRoutes.mainView);
                          } else {
                            // showSnackBar(context, 'Invalid email or password');
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
        ),
      ),
    );
  }
}
