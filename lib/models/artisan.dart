// ignore_for_file: non_constant_identifier_names

import 'package:algeria_eats/models/product.dart';
import 'package:algeria_eats/models/user.dart';

class Artisan {
  int? user_id;
  int rating;
  User user;
  List<Product>? products;
  String desc_entreprise;
  String heure_ouverture;
  String heure_fermeture;
  String type_service;
  String created_at;
  String updated_at;

  Artisan({
    required this.user_id,
    this.products,
    required this.desc_entreprise,
    required this.heure_ouverture,
    required this.heure_fermeture,
    required this.rating,
    required this.type_service,
    required this.created_at,
    required this.updated_at,
    required this.user,
  });
  Map<String, dynamic> toMap() {
    return {
      'user_id': user_id,
      'rating': rating,
      'desc_entreprise': desc_entreprise,
      'heure_ouverture': heure_ouverture,
      'heure_fermeture': heure_fermeture,
      'type_service': type_service,
      'created_at': created_at,
      'updated_at': updated_at,
      'user': user.toMap(),
      'products': products!.map((e) => e.toMap()).toList(),
    };
  }

  factory Artisan.fromJson(Map<String, dynamic> map) {
    return Artisan(
      user_id: map['user_id'],
      rating: map['rating'],
      desc_entreprise: map['desc_entreprise'],
      heure_ouverture: map['heure_ouverture'],
      heure_fermeture: map['heure_fermeture'],
      type_service: map['type_service'],
      created_at: map['created_at'],
      updated_at: map['updated_at'],
      user: User.fromJson(map['user']),
      products: List<Product>.from(
          map['Products']?.map((x) => Product.fromJson(x)) ?? []),
    );
  }
}
