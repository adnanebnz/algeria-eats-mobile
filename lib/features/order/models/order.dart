// ignore_for_file: non_constant_identifier_names

import 'package:algeria_eats/features/artisans/models/artisan.dart';
import 'package:algeria_eats/features/products/models/product.dart';
import 'package:algeria_eats/features/auth/models/user.dart';

class Order {
  int id;
  int buyer_id;
  int artisan_id;
  String status;
  String wilaya;
  String daira;
  String commune;
  String created_at;
  String updated_at;
  User buyer;
  Artisan artisan;
  List<Product> orderItems;

  Order({
    required this.id,
    required this.buyer_id,
    required this.artisan_id,
    required this.status,
    required this.wilaya,
    required this.daira,
    required this.commune,
    required this.created_at,
    required this.updated_at,
    required this.buyer,
    required this.artisan,
    required this.orderItems,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      buyer_id: json['buyer_id'],
      artisan_id: json['artisan_id'],
      status: json['status'],
      wilaya: json['wilaya'],
      daira: json['daira'],
      commune: json['commune'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      buyer: User.fromJson(json['buyer']),
      artisan: Artisan.fromJson(json['artisan']),
      orderItems: (json['order_items'] as List<dynamic>)
          .map((productJson) => Product.fromJson(productJson))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'buyer_id': buyer_id,
      'artisan_id': artisan_id,
      'status': status,
      'wilaya': wilaya,
      'daira': daira,
      'commune': commune,
      'created_at': created_at,
      'updated_at': updated_at,
      'buyer': buyer.toMap(),
      'artisan': artisan.toMap(),
      'order_items': orderItems.map((product) => product.toMap()).toList(),
    };
  }
}
