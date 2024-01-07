import 'package:algeria_eats/models/artisan.dart';
import 'package:flutter/material.dart';

class ArtisanProfileScreen extends StatefulWidget {
  final Artisan artisan;
  const ArtisanProfileScreen({super.key, required this.artisan});

  @override
  State<ArtisanProfileScreen> createState() => _ArtisanProfileScreenState();
}

class _ArtisanProfileScreenState extends State<ArtisanProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: const BackButton(color: Colors.black),
      ),
      body: SafeArea(
          child: ListView(
        children: [
          Container(
            child: Container(
              child: Row(
                children: [
                  //profile pic
                  Column(
                    children: [
                      //nom et prenom
                      //rating
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
