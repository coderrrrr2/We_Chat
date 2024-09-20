import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:practice_chat_app/core/init/init_services.dart';
import 'package:practice_chat_app/features/auth/presentation/routes/routes.dart';
import 'package:practice_chat_app/features/auth/presentation/view/widgets/verification_email_dialog_content.dart';
import 'package:practice_chat_app/features/home/presentation/routes/routes.dart';
import 'package:practice_chat_app/features/home/presentation/view/chat_page.dart';
import 'package:practice_chat_app/features/home/presentation/view/widgets/chat_tile.dart';
import 'package:practice_chat_app/features/navigation/app_navigator.dart';
import 'package:practice_chat_app/models/user_model.dart';
import 'package:practice_chat_app/shared/utils/app_alert.dart';
import 'package:practice_chat_app/shared/utils/app_color.dart';
import 'package:practice_chat_app/shared/widgets/app_dialog.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        if (authService.user != null) {
          if (!authService.user!.emailVerified) {
            AppDialog.showCustomDialog(
                VerificationEmailDialogContent(
                  isLoggedIn: true,
                  onDimssed: () async {
                    await authService.logout().then(
                      (value) {
                        AppNavigator.popDialog();
                        AppNavigator.replaceAllRoutes(
                            AuthRoutes.chooseLoginView);
                      },
                    );
                  },
                ),
                context: context);
          }
        } else {
          log("user is null");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text('Messsages'),
          actions: [
            IconButton(
                onPressed: () async {
                  authService.logout().then(
                    (isLoggedOut) {
                      if (isLoggedOut) {
                        AppNavigator.replaceAllRoutes(
                            AuthRoutes.chooseLoginView);
                      } else {
                        AppAlert.showToast(context,
                            message: "Failed to Logout, Try again");
                      }
                    },
                  );
                },
                icon: const Icon(
                  Icons.logout,
                  color: redColor,
                ))
          ],
        ),
        body: StreamBuilder(
          stream: chatService.getUserProfiles(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Unable to load data"),
              );
            }
            if (snapshot.hasData && snapshot.data != null) {
              final users = snapshot.data!.docs;
              if (users.length == 0) {
                return const Center(
                  child: Text("No users found"),
                );
              }
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  UserProfile user = users[index].data();
                  return ChatTile(
                    userProfile: user,
                    ontap: () async {
                      final isChatExists = await chatService.checkIfChatExits(
                          authService.user!.uid, user.uid);
                      if (isChatExists) {
                        AppNavigator.pushRoute(HomeRoutes.chatView,
                            arguments: ChatPageArgs(userProfile: user));
                      } else {
                        await chatService.createNewChat(
                            authService.user!.uid, user.uid);
                        AppNavigator.pushRoute(HomeRoutes.chatView,
                            arguments: ChatPageArgs(userProfile: user));
                      }
                    },
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          },
        ));
  }
}
