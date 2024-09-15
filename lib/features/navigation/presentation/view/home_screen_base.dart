import 'package:flutter/material.dart';
import 'package:practice_chat_app/features/home/presentation/view/home_view.dart';
import 'package:practice_chat_app/features/navigation/viewmodel/bottom_navbar_provider.dart';
import 'package:practice_chat_app/features/settings/presentation/view/settings_view.dart';
import 'package:provider/provider.dart';

class HomeScreenBase extends StatelessWidget {
  const HomeScreenBase({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavbarProvider>(
      builder: (_, vm, __) => Scaffold(
        body: IndexedStack(
          index: vm.currentIndex,
          children: const [HomeView(), SettingsView()],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: vm.currentIndex,
          onTap: (value) {
            vm.updateCurrentIndex(value);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
