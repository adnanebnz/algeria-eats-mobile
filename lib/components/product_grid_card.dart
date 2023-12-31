import 'package:algeria_eats/models/product.dart';
import 'package:flutter/material.dart';

class ProductGridCard extends StatelessWidget {
  const ProductGridCard({
    Key? key,
    required this.product,
    required this.onTap,
    this.width = 400,
  }) : super(key: key);

  final Product product;
  final Function onTap;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            onTap();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(22)),
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  product.images[0],
                  fit: BoxFit.fitWidth,
                  height: 150,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                product.nom,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        SizedBox(
            width: width,
            child: LikeListTile(
              title:
                  "${product.artisan.user.nom} ${product.artisan.user.prenom}",
              likes: product.artisan.rating.toString(),
              subtitle: "103 Reviews",
              color: Colors.orangeAccent,
            ))
      ],
    );
  }
}

class LikeListTile extends StatelessWidget {
  const LikeListTile(
      {Key? key,
      required this.title,
      required this.likes,
      required this.subtitle,
      this.color = Colors.grey})
      : super(key: key);
  final String title;
  final String likes;
  final String subtitle;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: SizedBox(
        width: 40,
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(
                        "https://profilemagazine.com/wp-content/uploads/2020/04/Ajmere-Dale-Square-thumbnail.jpg"))),
          ),
        ),
      ),
      title: Text(title, style: const TextStyle(fontSize: 11)),
      subtitle: Row(
        children: [
          const Icon(Icons.favorite, color: Colors.orange, size: 12),
          const SizedBox(width: 2),
          Text(likes, style: TextStyle(fontSize: 11)),
          Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: SizedBox(width: 4, height: 4),
              )),
          Text(subtitle, style: TextStyle(fontSize: 11))
        ],
      ),
    );
  }
}

class LikeButton extends StatefulWidget {
  const LikeButton(
      {Key? key, required this.onPressed, this.color = Colors.black12})
      : super(key: key);
  final Function onPressed;
  final Color color;
  @override
  // ignore: library_private_types_in_public_api
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(isLiked ? Icons.favorite : Icons.favorite_border,
          color: widget.color),
      onPressed: () {
        setState(() {
          isLiked = !isLiked;
        });
        widget.onPressed();
      },
    );
  }
}
