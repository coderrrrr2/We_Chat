import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:practice_chat_app/core/init/init_services.dart';
import 'package:practice_chat_app/core/services/image_picker_service.dart';
import 'package:practice_chat_app/models/user_model.dart';
import 'package:practice_chat_app/shared/shared_widgets.dart';
import 'package:practice_chat_app/shared/utils/app_alert.dart';
import 'package:practice_chat_app/shared/utils/app_color.dart';
import 'package:practice_chat_app/shared/utils/text.dart';
import 'package:practice_chat_app/shared/widgets/app_button.dart';
import 'package:practice_chat_app/shared/widgets/app_column.dart';
import 'package:practice_chat_app/shared/widgets/app_textfield.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final nameController = TextEditingController();
  bool isEdited = false;
  File? selectedImage;

  @override
  void initState() {
    super.initState();
    // nameController.text = authService.user!.displayName!;
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          AppButton(
              textColor: blackColor,
              backgroundColor: whiteColor,
              buttonSize: const Size(60, 40),
              onPressed: () {
                setState(() {
                  isEdited = !isEdited;
                });
              },
              text: isEdited ? "Save" : "Edit"),
          addWidth(10),
        ],
      ),
      body: StreamBuilder(
          stream: profileService.getUserProfile(),
          builder: (context, snapshot) {
            final data = snapshot.data!.docs;
            final user = data[0].data();
            return AppColumn(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      if (isEdited) {
                        final pickedImage =
                            await ImagePickerService.pickImageFromGallery();
                        setState(() {
                          selectedImage = pickedImage;
                        });
                      }
                    },
                    child: Container(
                      width: 150,
                      height: 150,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: whiteColor,
                        image: DecorationImage(
                            image: selectedImage != null
                                ? FileImage(selectedImage!)
                                : NetworkImage(user.pfpUrl),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  if (selectedImage != null) ...[
                    GestureDetector(
                        onTap: () {
                          selectedImage!.delete();
                          setState(() {
                            selectedImage = null;
                          });
                        },
                        child: const Icon(Icons.delete))
                  ]
                ],
              ),
              addHeight(10),
              Center(
                child: AppText(
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  text: user.name,
                ),
              ),
              addHeight(20),
              AppTextField(
                isReadOnly: !isEdited,
                controller: nameController,
                header: 'Name',
              ),
              // AppTextField(controller: nameController, header: 'Email'),
              // AppTextField(controller: nameController, header: 'Phone'),
              addHeight(280),
              AppButton(
                  isEnabled: isEdited,
                  onPressed: () async {
                    log("is Started");
                    UserProfile? currentUser =
                        await profileService.getUserData(authService.user!.uid);
                    if (currentUser != null) {
                      String imageUrl = '';
                      final String userId = currentUser.uid;
                      if (selectedImage != null) {
                        final updatedImageUrl =
                            await profileService.updateProfilePicture(
                                file: selectedImage!, uid: userId);
                        log("image  url is $updatedImageUrl");

                        if (updatedImageUrl != null) {
                          imageUrl = updatedImageUrl;
                        }
                      }
                      UserProfile updatedUserData = currentUser;
                      if (nameController.text != currentUser.name) {
                        updatedUserData =
                            updatedUserData.copyWith(name: nameController.text);
                      }
                      if (imageUrl.isNotEmpty) {
                        updatedUserData =
                            updatedUserData.copyWith(pfpUrl: imageUrl);
                      }
                      log("OLD URL IS ${currentUser.pfpUrl}");
                      log("NEW URL IS $imageUrl");

                      final isUpdated = await profileService.updateUserData(
                          updatedUserData, currentUser.pfpUrl);
                      if (isUpdated) {
                        AppAlert.showToast(context,
                            message: "Proifle Updated Succesfully");
                      } else {
                        AppAlert.showToast(context,
                            message: "An Error Occured please try again");
                      }
                      return;
                    }
                    if (!context.mounted) return;
                    AppAlert.showToast(context,
                        message: "Please Check your Internet Connection");
                  },
                  text: "Update"),
            ]);
          }),
    );
  }
}
