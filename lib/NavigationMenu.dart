
import 'package:fkfa/screens/Camera.dart';
import 'package:fkfa/screens/Feed.dart';
import 'package:fkfa/screens/Friends.dart';
import 'package:fkfa/screens/Profile.dart';
import 'package:fkfa/screens/Tasks.dart';
import 'package:fkfa/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final dark = fkfaHelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
            () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
          controller.selectedIndex.value = index,
          backgroundColor: dark ? Colors.black : Colors.white,
          indicatorColor: dark
              ? Colors.white.withOpacity(0.1)
              : Colors.black.withOpacity(0.1),
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.facebook), label: 'Feed'),
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Tasks'),
            NavigationDestination(icon: Icon(Iconsax.shop), label: 'Camera'),
            NavigationDestination(icon: Icon(Iconsax.heart), label: 'Friends'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(
            () => Directionality(
          textDirection: TextDirection.ltr, // Ensure left-to-right text direction
          child: controller.screens[controller.selectedIndex.value],
        ),
      ),

    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const Tasksscreen(),
    const FeedScreen(),
    const CameraScreen(),
    const FriendsScreen(),
    const ProfileScreen(),
  ];
}
