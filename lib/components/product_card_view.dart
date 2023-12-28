import 'package:algeria_eats/components/rating_view.dart';
import 'package:algeria_eats/models/product.dart';
import 'package:flutter/material.dart';

class ProductCardView extends StatelessWidget {
  const ProductCardView(
      {Key? key,
      required this.product,
      this.imageAlignment = Alignment.bottomCenter,
      this.onTap})
      : super(key: key);

  final Product product;
  final Alignment imageAlignment;
  final Function(String)? onTap;

  @override
  Widget build(BuildContext context) {
    final priceValue = product.prix;

    return GestureDetector(
      onTap: () => onTap?.call(product.id.toString()),
      child: SizedBox(
        width: 100,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              SizedBox(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(frameBuilder: (BuildContext context,
                          Widget child,
                          int? frame,
                          bool wasSynchronouslyLoaded) {
                    if (wasSynchronouslyLoaded) {
                      return child;
                    }
                    return AnimatedOpacity(
                      child: child,
                      opacity: frame == null ? 0 : 1,
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeOut,
                    );
                  }, 'https://plus.unsplash.com/premium_photo-1678198828975-02016abf2c5e?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      // TODO REPLACE WITH REAL IMAGE
                      alignment: imageAlignment,
                      fit: BoxFit.cover)),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
              child: Text(product.categorie == 'sucree' ? 'Sucrée' : 'Salée',
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
                      fontWeight: FontWeight.bold, color: Colors.orangeAccent)),
            ],
          ),
          RatingView(
            iconSize: 16,
            fontSize: 16,
            value: product.rating?.toInt() ?? 0,
          ),
        ]),
      ),
    );
  }
}
