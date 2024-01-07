import 'package:algeria_eats/components/artisan_card.dart';
import 'package:algeria_eats/controllers/artisanController.dart';
import 'package:algeria_eats/screens/artisan_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArtisansScreen extends StatefulWidget {
  const ArtisansScreen({super.key});

  @override
  State<ArtisansScreen> createState() => _ArtisansScreenState();
}

class _ArtisansScreenState extends State<ArtisansScreen> {
  ArtisanController artisanController = Get.put(ArtisanController());

  @override
  void initState() {
    artisanController.getArtisans();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<ArtisanController>(builder: (controller) {
        return ListView.builder(
            itemCount: controller.artisans.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(12.0),
                child: ArtisanCard(
                  artisan: controller.artisans[index],
                  onTap: (userId) {
                    Get.to(() => ArtisanProfileScreen(
                          artisan: controller.artisans[index],
                        ));
                  },
                ),
              );
            });
      }),
    );
  }
}
