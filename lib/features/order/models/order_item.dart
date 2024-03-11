// ignore_for_file: non_constant_identifier_names

import 'package:algeria_eats/features/products/models/product.dart';

class OrderItem {
  int id;
  int order_id;
  int product_id;
  int quantity;
  double prix_total;
  String created_at;
  String updated_at;
  Product product;

  OrderItem({
    required this.id,
    required this.order_id,
    required this.product_id,
    required this.quantity,
    required this.prix_total,
    required this.created_at,
    required this.updated_at,
    required this.product,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      order_id: json['order_id'],
      product_id: json['product_id'],
      quantity: json['quantity'],
      prix_total: json['prix_total'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      product: Product.fromJson(json['product']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'order_id': order_id,
      'product_id': product_id,
      'quantity': quantity,
      'prix_total': prix_total,
      'created_at': created_at,
      'updated_at': updated_at,
      'product': product.toMap(),
    };
  }
}
