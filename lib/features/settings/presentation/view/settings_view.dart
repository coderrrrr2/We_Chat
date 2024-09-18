import 'package:flutter/material.dart';
import 'package:practice_chat_app/core/init/init_services.dart';
import 'package:practice_chat_app/features/navigation/app_navigator.dart';
import 'package:practice_chat_app/features/settings/presentation/routes/routes.dart';
import 'package:practice_chat_app/features/settings/viewmodel/session_provider.dart';
import 'package:practice_chat_app/shared/shared_widgets.dart';
import 'package:practice_chat_app/shared/utils/text.dart';
import 'package:practice_chat_app/shared/widgets/app_column.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SessionProvider>(builder: (_, vm, __) {
      final isLightMode = vm.isLightMode;
      return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
        ),
        body: StreamBuilder(
            stream: profileService.getUserProfile(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {}
              final data = snapshot.data!.docs;
              final user = data[0].data();

              return AppColumn(children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(user.pfpUrl),
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
                ListTile(
                  title: Row(
                    children: [
                      Text(vm.isLightMode ? "Light Mode" : "Dark Mode"),
                      addWidth(10),
                      Icon(isLightMode ? Icons.sunny : Icons.dark_mode),
                    ],
                  ),
                  trailing: Switch(
                    value: vm.isLightMode,
                    onChanged: (value) {
                      vm.updateModeStatus(value);
                    },
                  ),
                ),
                addHeight(10),
                ListTile(
                  title: const Text("View Profile"),
                  trailing: const Icon(Icons.person),
                  onTap: () {
                    AppNavigator.pushRoute(SettingsRoutes.profileView);
                  },
                ),
              ]);
            }),
      );
    });
  }
}
