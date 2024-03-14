import 'package:algeria_eats/features/products/models/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FeaturedProductCard extends StatelessWidget {
  const FeaturedProductCard(
      {Key? key,
      required this.product,
      this.imageAlignment = Alignment.bottomCenter,
      required this.onTap})
      : super(key: key);

  final Product product;
  final Alignment imageAlignment;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final priceValue = product.prix;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        width: MediaQuery.of(context).size.width * 0.6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.5),
          color: Colors.white,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: CachedNetworkImage(
                    imageUrl: product.images[0],
                    alignment: imageAlignment,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                Positioned(
                  top: 8.0,
                  right: 8.0,
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Row(children: [
                      Text(product.rating.toString()),
                      const SizedBox(width: 3.0),
                      SvgPicture.asset('assets/images/star.svg',
                          color: Colors.orange[600]!, width: 16.0),
                    ]),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
              child: Text(product.categorie == 'sucree' ? 'Sucrée' : 'Salée',
                  style: Theme.of(context).textTheme.bodySmall)),
          SizedBox(
              child: Text(product.nom,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium)),
          Row(
            children: [
              Text('$priceValue DZD',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.orange)),
            ],
          ),
        ]),
      ),
    );
  }
}
