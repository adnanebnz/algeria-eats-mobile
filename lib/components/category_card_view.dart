import 'package:flutter/material.dart';

class CategoryCardView extends StatelessWidget {
  const CategoryCardView({
    Key? key,
    required this.title,
    required this.image,
    this.onTap,
  }) : super(key: key);

  final String title;
  final String image;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8.0, left: 8.0),
        width: MediaQuery.of(context).size.width * 0.8,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
            colors: [Color(0xff53E88B), Color(0xff15BE77)],
          ),
        ),
        child: Stack(
          children: [
            Opacity(
              opacity: 0.5,
              child: Image.network(
                "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/BACKGROUND%202.png?alt=media&token=0d003860-ba2f-4782-a5ee-5d5684cdc244",
                fit: BoxFit.cover,
              ),
            ),
            Image.network(
              "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/Image.png?alt=media&token=8256c357-cf86-4f76-8c4d-4322d1ebc06c",
            ),
            const Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.all(25.0),
                child: Text(
                  "Produits\nSucrée",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
