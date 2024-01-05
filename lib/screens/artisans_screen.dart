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
      body: Container(
        width: 235,
        child: ArtisanCard(
          title: "hey",
          onMoreTap: () {},
        ),
      ),
    );
  }
}
