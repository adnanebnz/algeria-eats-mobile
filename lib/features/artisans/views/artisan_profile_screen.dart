import 'package:algeria_eats/components/rating_view.dart';
import 'package:algeria_eats/components/user_profile_pic.dart';
import 'package:algeria_eats/features/artisans/models/artisan.dart';
import 'package:algeria_eats/features/artisans/views/components/data_row.dart';
import 'package:algeria_eats/features/products/views/product_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ArtisanProfileScreen extends StatelessWidget {
  const ArtisanProfileScreen({super.key, required this.artisan});
  final Artisan artisan;

  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Artisan'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
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
                        UserProfilePic(
                          image: artisan.user.image,
                          radius: 25,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${artisan.user.nom} ${artisan.user.prenom}",
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600),
                            ),
                            RatingView(
                              value: artisan.rating,
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
                            artisan.type_service == "sucree"
                                ? "Sucrée"
                                : artisan.type_service == "salee"
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
                          DateFormat.yMMMd()
                              .format(DateTime.parse(artisan.created_at)),
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
                  buildDataRow('Nom', artisan.user.nom, context),
                  buildDataRow('Prénom', artisan.user.prenom, context),
                  buildDataRow('Adresse', artisan.user.adresse, context),
                  buildDataRow('Wilaya', artisan.user.wilaya, context),
                  buildDataRow('Email', artisan.user.email, context),
                  buildDataRow(
                    'Numéro de téléphone',
                    artisan.user.num_telephone,
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
                    artisan.desc_entreprise,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 12.5,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 15),
                  buildDataRow(
                      "Heure d'ouverture", artisan.heure_ouverture, context),
                  buildDataRow(
                      "Heure de fermeture", artisan.heure_fermeture, context),
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
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: artisan.products?.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            Get.to(() => ProductScreen(
                                  product: artisan.products![index],
                                ));
                          },
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: artisan.products![index].images[0],
                              height:
                                  70, // Increase this value to make the image bigger
                            ),
                          ),
                          title: Text(
                            artisan.products![index].nom,
                          ),
                          subtitle: RatingView(
                              value: artisan.products![index].rating ?? 0,
                              iconSize: 15,
                              fontSize: 15),
                          trailing: Text(
                            '${artisan.products![index].prix} DA',
                            style: const TextStyle(fontSize: 13),
                          ),
                        );
                      })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
