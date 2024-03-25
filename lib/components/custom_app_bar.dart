// ignore_for_file: deprecated_member_use

import 'package:algeria_eats/components/user_app_bar_shimmer.dart';
import 'package:algeria_eats/components/user_profile_pic.dart';
import 'package:algeria_eats/core/services/geolocation_service.dart';
import 'package:algeria_eats/features/auth/controllers/auth_controller.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    final GeoLocationService geoLocationService = Get.find();
    return Container(
      padding: const EdgeInsets.only(top: 12, left: 5, right: 5),
      child: AppBar(
        primary: true,
        leading: Builder(
          builder: (context) => GestureDetector(
            child: Icon(
              FluentIcons.list_28_filled,
              color: Colors.grey[800]!,
              size: 28,
            ),
            onTap: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        centerTitle: true,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Localisation actuelle",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 11,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/location.svg',
                  height: 16,
                  width: 16,
                  color: Colors.orange[600],
                ),
                const SizedBox(
                  width: 2,
                ),
                Obx(() => Text(
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w500),
                    "${geoLocationService.currentCity} ${geoLocationService.currentCountry}")),
              ],
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Obx(
              () {
                if (authController.isLoading.value) {
                  return const UserProfilePicShimmer();
                } else {
                  return UserProfilePic(
                    image: authController.user.value.image,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
