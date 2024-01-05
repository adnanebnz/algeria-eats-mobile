import 'package:algeria_eats/components/artisan_card.dart';
import 'package:algeria_eats/controllers/artisanController.dart';
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
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1.9,
            mainAxisSpacing: 12,
            crossAxisSpacing: 4,
            crossAxisCount: 1,
          ),
          itemCount: 2,
          itemBuilder: (context, index) {
            return ArtisanCard(
              title: "Artisan",
              body: "Lorem ipsum dolor",
              onMoreTap: () {},
            );
          }),
    );
  }
}
