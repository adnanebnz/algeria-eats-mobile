import 'package:algeria_eats/components/rating_view.dart';
import 'package:algeria_eats/components/user_profile_pic.dart';
import 'package:algeria_eats/features/artisans/models/artisan.dart';
import 'package:flutter/material.dart';

class ArtisanCard extends StatelessWidget {
  const ArtisanCard({
    Key? key,
    required this.artisan,
    required this.onTap,
  }) : super(key: key);

  final Artisan artisan;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(artisan.user_id!);
      },
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 1),
              ),
            ],
            color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                UserProfilePic(
                  image: artisan.user.image,
                  radius: 25,
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.70,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${artisan.user.nom} ${artisan.user.prenom}",
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                      RatingView(
                        value: artisan.rating,
                        fontSize: 20,
                        iconSize: 20,
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined,
                          color: Colors.grey[700], size: 30),
                      const SizedBox(width: 5),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          "${artisan.user.adresse}, ${artisan.user.wilaya}",
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.fastfood_outlined,
                          color: Colors.grey[700], size: 30),
                      const SizedBox(width: 5),
                      Text(
                        artisan.type_service == 'sucree' ? 'Sucrée' : 'Salée',
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
