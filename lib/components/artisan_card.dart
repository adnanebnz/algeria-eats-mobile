import 'package:algeria_eats/components/rating_view.dart';
import 'package:algeria_eats/models/artisan.dart';
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
              color: Colors.black.withOpacity(.05),
              offset: const Offset(0, 10),
              blurRadius: 0,
              spreadRadius: 0,
            )
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
                  CircleAvatar(
                      radius: 25,
                      child: Image.network(
                        artisan.user.image ?? "https://picsum.photos/200",
                      )),
                  const SizedBox(width: 10),
                  Column(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Icon(Icons.location_on_outlined,
                      color: Colors.grey[700], size: 30),
                  const SizedBox(width: 5),
                  Text(
                    "${artisan.user.adresse}, ${artisan.user.wilaya}",
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
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
        ],
      ),
    );
  }
}
