import 'package:algeria_eats/components/user_app_bar_shimmer.dart';
import 'package:algeria_eats/components/user_profile_pic.dart';
import 'package:algeria_eats/features/auth/controllers/auth_controller.dart';
import 'package:algeria_eats/features/intro/views/on_board_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(251, 146, 60, 1),
            ),
            child: Obx(() {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(
                    () {
                      if (authController.isLoading.value) {
                        return const UserProfilePicShimmer(
                          radius: 40,
                        );
                      } else {
                        return UserProfilePic(
                          image: authController.user.value.image,
                          radius: 40,
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  Text(
                    authController.user.value.nom,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    authController.user.value.prenom,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              );
            }),
          ),
          _buildListTile(
            icon: Icons.shopping_bag_outlined,
            text: 'Mes achats',
            onTap: () {
              Get.toNamed("/user-orders");
            },
          ),
          _buildListTile(
            icon: Icons.settings_outlined,
            text: 'Paramétres',
            onTap: () {
              // TODO: Add Settings Page
            },
          ),
          _buildListTile(
            icon: Icons.logout,
            text: 'Déconnexion',
            onTap: () {
              authController
                  .logout()
                  .then((value) => {Get.offAll(() => const OnBoardPage())});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(
      {required IconData icon,
      required String text,
      required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        leading: Icon(icon),
        title: Text(text),
        onTap: onTap,
        tileColor: Colors.white,
      ),
    );
  }
}
