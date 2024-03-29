import 'package:algeria_eats/components/user_profile_pic.dart';
import 'package:algeria_eats/features/artisans/models/artisan.dart';
import 'package:algeria_eats/features/artisans/views/artisan_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NeirestArtisanProfile extends StatelessWidget {
  const NeirestArtisanProfile({super.key, required this.artisan});
  final Artisan artisan;
  @override
  @override
  build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ArtisanProfileScreen(artisan: artisan));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          UserProfilePic(
            image: artisan.user.image,
            radius: 27,
          ),
          const SizedBox(
            height: 7,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  artisan.user.nom,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  artisan.type_service == "sucree"
                      ? "Sucrée"
                      : artisan.type_service == "salee"
                          ? "Salée"
                          : "Sucrée et Salée",
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
