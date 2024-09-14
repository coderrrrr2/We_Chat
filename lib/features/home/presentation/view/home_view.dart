import 'package:flutter/material.dart';
import 'package:practice_chat_app/core/init/init_services.dart';
import 'package:practice_chat_app/features/auth/presentation/routes/routes.dart';
import 'package:practice_chat_app/features/navigation/app_navigator.dart';
import 'package:practice_chat_app/shared/utils/app_alert.dart';
import 'package:practice_chat_app/shared/utils/app_color.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
                        AppAlert.showToast(context,
                            message: "Succesfully Logged out");
                        AppNavigator.replaceAllRoutes(AuthRoutes.login);
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
          stream: dataBaseService.getUserProfiles(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Unable to load data"),
              );
            }
            if (snapshot.hasData && snapshot.data != null) {
              return ListView();
            }
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          },
        ));
  }
}
