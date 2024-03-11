// ignore_for_file: non_constant_identifier_names

import 'package:algeria_eats/features/artisans/models/artisan.dart';
import 'package:algeria_eats/features/reviews/models/review.dart';

class Product {
  int id;
  int artisan_id;
  String nom;
  String description;
  double prix;
  int? rating;
  String categorie;
  List<String> images;
  Artisan? artisan;
  String created_at;
  String updated_at;
  List<Review>? reviews;

  Product({
    required this.id,
    required this.artisan_id,
    required this.nom,
    required this.description,
    required this.prix,
    required this.rating,
    required this.categorie,
    required this.images,
    required this.artisan,
    required this.created_at,
    required this.updated_at,
    this.reviews,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'artisan_id': artisan_id,
      'nom': nom,
      'description': description,
      'prix': prix,
      'rating': rating,
      'categorie': categorie,
      'images': images,
      'artisan': artisan?.toMap(),
      'created_at': created_at,
      'updated_at': updated_at,
      'reviews': reviews?.map((x) => x.toMap()).toList(),
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      artisan_id: json['artisan_id'],
      nom: json['nom'],
      description: json['description'],
      prix: json['prix'].toDouble(),
      rating: json['rating'],
      categorie: json['categorie'],
      images: List<String>.from(json['images']),
      artisan:
          json['artisan'] != null ? Artisan.fromJson(json['artisan']) : null,
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      reviews: json['reviews'] != null
          ? List<Review>.from(json['reviews'].map((x) => Review.fromJson(x)))
          : null,
    );
  }
}
