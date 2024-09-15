import 'package:flutter/material.dart';
import 'package:practice_chat_app/features/navigation/app_navigator.dart';
import 'package:practice_chat_app/features/settings/presentation/routes/routes.dart';
import 'package:practice_chat_app/shared/shared_widgets.dart';
import 'package:practice_chat_app/shared/widgets/app_column.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool isLightMode = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
        ),
        body: AppColumn(children: [
          ListTile(
            title: Row(
              children: [
                Text(isLightMode ? "Light Mode" : "Dark Mode"),
                addWidth(10),
                Icon(isLightMode ? Icons.sunny : Icons.dark_mode),
              ],
            ),
            trailing: Switch(
              value: isLightMode,
              onChanged: (value) {
                setState(() {
                  isLightMode = value;
                });
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
        ]));
  }
}
