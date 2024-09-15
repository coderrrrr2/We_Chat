import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:practice_chat_app/core/app_validator.dart';
import 'package:practice_chat_app/core/init/init_services.dart';
import 'package:practice_chat_app/core/services/image_picker_service.dart';
import 'package:practice_chat_app/features/auth/presentation/routes/routes.dart';
import 'package:practice_chat_app/features/auth/viewmodel/auth_provider.dart';
import 'package:practice_chat_app/features/home/presentation/routes/routes.dart';
import 'package:practice_chat_app/features/navigation/app_navigator.dart';
import 'package:practice_chat_app/models/user_model.dart';
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
  final ImagePickerService imagePicker = ImagePickerService();
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
              addHeight(20),
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
              addHeight(10),
              AppButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate() &&
                        _selectedImage != null) {
                      final isSignedUp = await vm.signUp(
                          emailController.text, passwordController.text);
                      if (isSignedUp) {
                        String? pfpUrl =
                            await storageService.uploadUserProfilePicture(
                                file: _selectedImage!,
                                uid: authService.user!.uid);
                        log(pfpUrl ?? "image not uploaded succesfully");
                        if (pfpUrl != null) {
                          if (!context.mounted) return;
                          final createUser =
                              await dataBaseService.createUserProfile(
                                  context: context,
                                  userProfile: UserProfile(
                                      uid: authService.user!.uid,
                                      name: nameController.text,
                                      pfpUrl: pfpUrl));
                          if (createUser) {
                            AppNavigator.replaceAllRoutes(HomeRoutes.baseView);
                          }
                        }
                      } else {
                        if (!context.mounted) return;

                        AppAlert.showToast(context,
                            message: "Failed to Login, Try again");
                      }
                    } else if (_selectedImage == null) {
                      AppAlert.showToast(context,
                          message: "An Image must be selected");
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
                  addHeight(20),
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
      onTap: () async {
        await imagePicker.pickImageFromGallery().then(
          (file) {
            if (file != null) {
              setState(() {
                _selectedImage = file;
              });
            } else {
              AppAlert.showToast(context, message: "An Error Occured");
            }
          },
        );
      },
      child: CircleAvatar(
        radius: MediaQuery.of(context).size.width * 0.15,
        backgroundImage:
            _selectedImage != null ? FileImage(_selectedImage!) : null,
      ),
    );
  }
}
