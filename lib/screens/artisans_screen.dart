// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:algeria_eats/components/artisan_card.dart';
import 'package:algeria_eats/components/search_input_view.dart';
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
  String _searchText = "";
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.only(bottom: 8.0, top: 8.0),
            child: SearchInput(
              onChanged: (value) {
                setState(() {
                  _searchText = value;
                });
              },
              textController: textController,
              hintText: 'Rechercher un artisan',
            ),
          ),
          Obx(() {
            if (artisanController.artisans.isEmpty &&
                !artisanController.isLoading.value) {
              return _buildEmptyState(context);
            } else if (artisanController.isLoading.value) {
              return _buildLoadingState(context);
            } else {
              return _buildArtisanList(_searchText, artisanController);
            }
          })
        ],
      ),
    );
  }
}

Widget _buildEmptyState(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
      ),
      const Center(
        child: Text("Aucun artisan trouvé"),
      ),
    ],
  );
}

Widget _buildLoadingState(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
      ),
      const Center(
        child: CircularProgressIndicator(),
      ),
    ],
  );
}

Widget _buildArtisanList(String _searchText, ArtisanController controller) {
  return Expanded(
    child: ListView.builder(
      itemCount: _searchText.isEmpty
          ? controller.artisans.length
          : controller.artisans
              .where((artisan) =>
                  artisan.user.nom
                      .toLowerCase()
                      .contains(_searchText.toLowerCase()) ||
                  artisan.user.prenom
                      .toLowerCase()
                      .contains(_searchText.toLowerCase()))
              .length,
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
      },
    ),
  );
}
