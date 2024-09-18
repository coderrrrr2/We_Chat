import 'dart:io';
import 'package:flutter/material.dart';
import 'package:practice_chat_app/core/init/init_services.dart';
import 'package:practice_chat_app/core/services/image_picker_service.dart';
import 'package:practice_chat_app/shared/shared_widgets.dart';
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
            return AppColumn(isScrollable: true, children: [
              Center(
                child: GestureDetector(
                  onTap: () async {
                    final pickedImage =
                        await ImagePickerService.pickImageFromGallery();
                    setState(() {
                      selectedImage = pickedImage;
                    });
                  },
                  child: Container(
                    width: 100,
                    height: 100,
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
                controller: nameController,
                header: 'Name',
              ),
              // AppTextField(controller: nameController, header: 'Email'),
              // AppTextField(controller: nameController, header: 'Phone'),
              addHeight(280),
              AppButton(isEnabled: isEdited, onPressed: () {}, text: "Update"),
            ]);
          }),
    );
  }
}
