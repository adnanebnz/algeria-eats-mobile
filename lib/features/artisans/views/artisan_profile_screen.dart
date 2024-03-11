import 'package:algeria_eats/components/rating_view.dart';
import 'package:algeria_eats/features/artisans/controllers/artisanController.dart';
import 'package:algeria_eats/features/artisans/models/artisan.dart';
import 'package:algeria_eats/features/products/views/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ArtisanProfileScreen extends StatefulWidget {
  final Artisan artisan;
  const ArtisanProfileScreen({super.key, required this.artisan});

  @override
  State<ArtisanProfileScreen> createState() => _ArtisanProfileScreenState();
}

class _ArtisanProfileScreenState extends State<ArtisanProfileScreen> {
  ArtisanController artisanController = Get.find<ArtisanController>();

  @override
  void initState() {
    artisanController.getArtisanProducts(widget.artisan);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 46, left: 12, right: 12, bottom: 12),
            child: ListView(
              children: [
                Column(children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.25),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 1),
                        ),
                      ],
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                    ),
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(widget
                                      .artisan.user.image ??
                                  'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${widget.artisan.user.nom} ${widget.artisan.user.prenom}",
                                  style: TextStyle(
                                      color: Colors.grey[800],
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600),
                                ),
                                RatingView(
                                  value: widget.artisan.rating,
                                  fontSize: 20,
                                  iconSize: 20,
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 0),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.25),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 1),
                        ),
                      ],
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Role"),
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Text(
                                'Artisan',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                        Divider(
                          color: Colors.grey[300],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Specialité"),
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text(
                                widget.artisan.type_service == "sucree"
                                    ? "Sucrée"
                                    : widget.artisan.type_service == "salee"
                                        ? "Salée"
                                        : "Sucrée et Salée",
                                style: const TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                        Divider(
                          color: Colors.grey[300],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Membre depuis"),
                            const SizedBox(width: 10),
                            Text(
                              DateFormat.yMMMd().format(
                                  DateTime.parse(widget.artisan.created_at)),
                              style: TextStyle(color: Colors.grey[800]),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.25),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 1),
                        ),
                      ],
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      )),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.person_outline,
                            color: Colors.orange,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "A propos",
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      buildDataRow('Nom', widget.artisan.user.nom, context),
                      buildDataRow(
                          'Prénom', widget.artisan.user.prenom, context),
                      buildDataRow(
                          'Adresse', widget.artisan.user.adresse, context),
                      buildDataRow(
                          'Wilaya', widget.artisan.user.wilaya, context),
                      buildDataRow('Email', widget.artisan.user.email, context),
                      buildDataRow(
                        'Numéro de téléphone',
                        widget.artisan.user.num_telephone,
                        context,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.25),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 1),
                        ),
                      ],
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.apartment_outlined,
                            color: Colors.orange,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Entreprise",
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Text("Description:",
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
                      const SizedBox(height: 5),
                      Text(
                        widget.artisan.desc_entreprise,
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 12.5,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 15),
                      buildDataRow("Heure d'ouverture",
                          widget.artisan.heure_ouverture, context),
                      buildDataRow("Heure de fermeture",
                          widget.artisan.heure_fermeture, context),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.25),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 1),
                        ),
                      ],
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      )),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.all_inbox_outlined,
                            color: Colors.orange,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Produits",
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GetX<ArtisanController>(
                        builder: (controller) {
                          if (controller.isLoading.value) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.artisanProducts.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () {
                                    Get.to(() => ProductScreen(
                                          product:
                                              controller.artisanProducts[index],
                                        ));
                                  },
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(artisanController
                                        .artisanProducts[index].images[0]),
                                  ),
                                  title: Text(
                                    artisanController
                                        .artisanProducts[index].nom,
                                  ),
                                  subtitle: RatingView(
                                      value: artisanController
                                              .artisanProducts[index].rating ??
                                          0,
                                      iconSize: 15,
                                      fontSize: 15),
                                  trailing: Text(
                                    '${artisanController.artisanProducts[index].prix} DA',
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              height: 40.0,
              width: 40.0,
              margin: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.all(
                  Radius.circular(8.0),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(2, 10)),
                ],
              ),
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                color: Colors.grey[800],
                iconSize: 22,
              ),
            ),
          ),
        ],
      )),
    );
  }
}

Widget buildDataRow(String label, String value, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width *
              0.4, // Set a consistent width for labels
          child: Text(
            label,
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    ),
  );
}
