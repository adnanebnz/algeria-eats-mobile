import 'package:algeria_eats/components/artisan_card.dart';
import 'package:algeria_eats/components/loader.dart';
import 'package:algeria_eats/components/search_input_view.dart';
import 'package:algeria_eats/features/artisans/controllers/artisan_controller.dart';
import 'package:algeria_eats/features/artisans/models/artisan.dart';
import 'package:algeria_eats/features/artisans/views/artisan_profile_screen.dart';
import 'package:algeria_eats/features/artisans/views/components/filter_artisans_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ArtisansScreen extends StatefulWidget {
  const ArtisansScreen({super.key});

  @override
  State createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ArtisansScreen> {
  final TextEditingController search = TextEditingController();

  final ArtisanController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: SearchInput(
                    onChanged: (value) {
                      controller.setArtisanName = value;
                    },
                    textController: search,
                    hintText: 'Rechercher un Artisan',
                  ),
                ),
                const SizedBox(width: 8.0),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ]),
                  child: IconButton(
                      onPressed: () {
                        // hide keyboard
                        FocusManager.instance.primaryFocus?.unfocus();
                        Get.bottomSheet(
                          FilterArtisanBottomSheet(controller: controller),
                          enableDrag: true,
                          isDismissible: true,
                          isScrollControlled: true,
                        );
                      },
                      icon: const Icon(Icons.filter_list_outlined)),
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: PagedListView<int, Artisan>.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  pagingController: controller.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<Artisan>(
                    animateTransitions: true,
                    noItemsFoundIndicatorBuilder: (context) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Aucun artisan trouvé',
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 18,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'La liste des artisans est vide.',
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    firstPageProgressIndicatorBuilder: (context) {
                      return const Center(
                        child: Loader(),
                      );
                    },
                    newPageProgressIndicatorBuilder: (context) {
                      return const Center(
                        child: Loader(),
                      );
                    },
                    itemBuilder: (context, item, index) => ArtisanCard(
                      onTap: (id) =>
                          Get.to(() => ArtisanProfileScreen(artisan: item)),
                      artisan: item,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
