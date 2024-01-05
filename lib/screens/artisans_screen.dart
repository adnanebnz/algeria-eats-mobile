import 'package:algeria_eats/components/artisan_card.dart';
import 'package:flutter/material.dart';

class ArtisansScreen extends StatefulWidget {
  const ArtisansScreen({super.key});

  @override
  State<ArtisansScreen> createState() => _ArtisansScreenState();
}

class _ArtisansScreenState extends State<ArtisansScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.8,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            crossAxisCount: 2,
          ),
          itemCount: 2,
          itemBuilder: (context, index) {
            return ArtisanCard(
              title: "Artisan",
              body:
                  "Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia, molestiae quas vel sint commodi repudi conseqr!",
              onMoreTap: () {},
            );
          }),
    );
  }
}
