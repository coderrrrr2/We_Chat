import 'dart:developer';
import 'dart:io';
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

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  File? _selectedImage;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (_, vm, __) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: formKey,
          child: AppColumn(
            isLoading: vm.isLoading,
            children: [
              const LeadingText(text: "Let's, get going!"),
              const TrailingText(
                  text: "Register an account using the form below"),
              addHeight(30),
              Center(child: _getImageContainer()),
              addHeight(10),
              AppTextField(
                controller: nameController,
                header: 'Name',
                validator: (p0) {
                  return AppValidator.validateName(p0);
                },
              ),
              AppTextField(
                controller: emailController,
                header: 'Email',
                obscureText: true,
                validator: (p0) {
                  return AppValidator.validateEmail(p0);
                },
              ),
              AppTextField(
                controller: passwordController,
                header: 'Password',
                obscureText: true,
                validator: (p0) {
                  return AppValidator.validatePassword(p0);
                },
              ),
              addHeight(30),
              AppButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      vm
                          .logIn(emailController.text, passwordController.text)
                          .then((value) {
                        if (value) {
                          log("login is succesful");
                          AppNavigator.replaceAllRoutes(HomeRoutes.mainView);
                        } else {
                          AppAlert.showToast(context,
                              message: "Failed to Login, Try again");
                        }
                      });
                    }
                  },
                  text: 'Register'),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () {
                      AppNavigator.replaceRoute(AuthRoutes.login);
                    },
                    child: const Text('Login'),
                  ),
                  addHeight(60),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getImageContainer() {
    return GestureDetector(
      onTap: () {},
      child: CircleAvatar(
        radius: MediaQuery.of(context).size.width * 0.15,
        backgroundImage:
            _selectedImage != null ? FileImage(_selectedImage!) : null,
      ),
    );
  }
}
