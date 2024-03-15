// ignore_for_file: non_constant_identifier_names

import 'package:algeria_eats/features/order/models/order.dart';

class User {
  int? id;
  String nom;
  String prenom;
  String email;
  String num_telephone;
  String adresse;
  String wilaya;
  String? image;
  String created_at;
  String updated_at;
  List<Order>? orders;

  User({
    this.id,
    this.orders,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.image,
    required this.num_telephone,
    required this.adresse,
    required this.wilaya,
    required this.created_at,
    required this.updated_at,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'image': image,
      'num_telephone': num_telephone,
      'adresse': adresse,
      'wilaya': wilaya,
      'created_at': created_at,
      'updated_at': updated_at,
      'orders': orders?.map((x) => x.toMap()).toList(),
    };
  }

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
        id: map['id'],
        nom: map['nom'],
        prenom: map['prenom'],
        email: map['email'],
        num_telephone: map['num_telephone'],
        adresse: map['adresse'],
        wilaya: map['wilaya'],
        created_at: map['created_at'],
        updated_at: map['updated_at'],
        image: map['image'],
        orders: map['orders'] != null
            ? List<Order>.from(map['orders'].map((x) => Order.fromJson(x)))
            : null);
  }
}
