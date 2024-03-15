import 'package:algeria_eats/components/rating_view.dart';
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
    return Container(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Builder(builder: (context) {
                    if (artisan.user.image != null) {
                      return CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(artisan.user.image!),
                      );
                    } else {
                      return const CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 25,
                        backgroundImage:
                            AssetImage('assets/images/profile-pic.png'),
                      );
                    }
                  }),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.40,
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
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.0),
                  border: Border.all(color: Colors.orange),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: GestureDetector(
                  onTap: () {
                    onTap(artisan.user_id!);
                  },
                  child: const Center(
                      child: Text(
                    "Voir",
                    style: TextStyle(color: Colors.orange),
                  )),
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
    );
  }
}
