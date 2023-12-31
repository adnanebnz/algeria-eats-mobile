// ignore_for_file: non_constant_identifier_names

import 'package:algeria_eats/models/artisan.dart';

class Product {
  int id;
  String nom;
  String description;
  double prix;
  int? rating;
  String categorie;
  List<String> images;
  Artisan artisan;
  String created_at;
  String updated_at;

  Product({
    required this.id,
    required this.nom,
    required this.description,
    required this.prix,
    required this.rating,
    required this.categorie,
    required this.images,
    required this.artisan,
    required this.created_at,
    required this.updated_at,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      nom: json['nom'],
      description: json['description'],
      prix: json['prix'].toDouble(),
      rating: json['rating'],
      categorie: json['categorie'],
      images: List<String>.from(json['images']),
      artisan: Artisan.fromJson(json['artisan']),
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
}
