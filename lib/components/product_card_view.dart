import 'package:algeria_eats/components/rating_view.dart';
import 'package:algeria_eats/models/product.dart';
import 'package:flutter/material.dart';

class ProductCardView extends StatelessWidget {
  const ProductCardView(
      {Key? key,
      required this.product,
      this.imageAlignment = Alignment.bottomCenter,
      required this.onTap})
      : super(key: key);

  final Product product;
  final Alignment imageAlignment;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    final priceValue = product.prix;

    return GestureDetector(
      onTap: () {
        onTap(product.id);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: const Offset(10, 20),
                blurRadius: 10,
                spreadRadius: 0,
                color: Colors.grey.withOpacity(.05)),
          ],
        ),
        child: IntrinsicHeight(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IntrinsicHeight(
                  child: Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      SizedBox(
                        height: 150,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            product.images[0],
                            alignment: imageAlignment,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                    child: Text(
                        product.categorie == 'sucree' ? 'Sucrée' : 'Salée',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: Theme.of(context).textTheme.bodySmall)),
                SizedBox(
                    child: Text(product.nom,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: Theme.of(context).textTheme.bodyMedium)),
                Row(
                  children: [
                    Text('$priceValue DZD',
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        softWrap: false,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.orangeAccent)),
                  ],
                ),
                RatingView(
                  iconSize: 16,
                  fontSize: 16,
                  value: product.rating?.toInt() ?? 0,
                ),
              ]),
        ),
      ),
    );
  }
}
