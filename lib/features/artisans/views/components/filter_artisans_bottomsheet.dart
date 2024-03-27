// ignore_for_file: deprecated_member_use

import 'package:algeria_eats/features/artisans/controllers/artisan_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class FilterArtisanBottomSheet extends StatelessWidget {
  const FilterArtisanBottomSheet({super.key, required this.controller});
  final ArtisanController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      height: Get.height * 0.5,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Container(
              height: 5,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Filtrer par note',
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 18,
              color: Colors.grey[800],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => RatingBar.builder(
                    initialRating: controller.artisanRating.value.toDouble(),
                    minRating: 0,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => SvgPicture.asset(
                      'assets/images/star.svg',
                      width: 15,
                      height: 15,
                      color: Colors.orange.shade600,
                    ),
                    onRatingUpdate: (rating) {
                      controller.artisanRating.value = rating.toInt();
                      // Add your filtering logic here
                    },
                  )),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Filtrer par type de produit',
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 18,
              color: Colors.grey[800],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    style: ButtonStyle(
                      side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(
                          color: controller.typeService.value == 'sucree_salee'
                              ? Colors.orange
                              : Colors.grey[700]!.withAlpha(140),
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(
                            vertical: 7.0, horizontal: 14.0),
                      ),
                    ),
                    onPressed: () {
                      controller.typeService.value = 'sucree_salee';
                    },
                    child: Text(
                      'Sucrée et Salée',
                      style: TextStyle(
                        color: controller.typeService.value == 'sucree_salee'
                            ? Colors.orange
                            : Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  OutlinedButton(
                    style: ButtonStyle(
                      side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(
                          color: controller.typeService.value == 'sucree'
                              ? Colors.orange
                              : Colors.grey[700]!.withAlpha(140),
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(
                            vertical: 7.0, horizontal: 14.0),
                      ),
                    ),
                    onPressed: () {
                      controller.typeService.value = 'sucree';
                    },
                    child: Text(
                      'Sucrée',
                      style: TextStyle(
                        color: controller.typeService.value == 'sucree'
                            ? Colors.orange
                            : Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  OutlinedButton(
                    style: ButtonStyle(
                      side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(
                          color: controller.typeService.value == 'salee'
                              ? Colors.orange
                              : Colors.grey[700]!.withAlpha(140),
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(
                            vertical: 7.0, horizontal: 14.0),
                      ),
                    ),
                    onPressed: () {
                      controller.typeService.value = 'salee';
                      // Add your filtering logic here
                    },
                    child: Text(
                      'Salée',
                      style: TextStyle(
                        color: controller.typeService.value == 'salee'
                            ? Colors.orange
                            : Colors.black,
                      ),
                    ),
                  ),
                ],
              )),
          const SizedBox(height: 16),
          Text(
            'Filtrer par ordre',
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 18,
              color: Colors.grey[800],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: FilledButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.orange.shade600),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered)) {
                            return Colors.orange.shade600.withOpacity(0.04);
                          }
                          if (states.contains(MaterialState.focused) ||
                              states.contains(MaterialState.pressed)) {
                            return Colors.orange.shade600.withOpacity(0.12);
                          }
                          return null;
                        },
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.all(14.0),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      controller.pagingController.refresh();
                      Get.back();
                    },
                    child: const Text(
                      'Filtrer',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    )),
              ),
              const SizedBox(width: 8),
              FilledButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.grey.shade900),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.all(14.0),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                onPressed: () {
                  controller.artisanRating.value = 0;
                  controller.typeService.value = '';
                  controller.search.value = "";
                  controller.pagingController.refresh();
                  Get.back();
                },
                child: const Text(
                  "Réinitialiser",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
