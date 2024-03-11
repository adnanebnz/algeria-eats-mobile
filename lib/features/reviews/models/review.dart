// ignore_for_file: non_constant_identifier_names

import 'package:algeria_eats/features/auth/models/user.dart';
import 'package:algeria_eats/features/products/models/product.dart';

class Review {
  int id;
  int user_id;
  int product_id;
  String title;
  String comment;
  int? rating;
  User? user;
  Product? product;
  Review(
      {required this.id,
      required this.user_id,
      required this.product_id,
      required this.title,
      required this.comment,
      this.rating,
      this.user,
      this.product});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': user_id,
      'product_id': product_id,
      'title': title,
      'comment': comment,
      'rating': rating,
      'user': user != null ? user!.toMap() : {'id': user_id, 'name': 'Unknown'},
      'product': product != null
          ? product!.toMap()
          : {'id': product_id, 'name': 'Unknown'}
    };
  }

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      user_id: json['user_id'],
      product_id: json['product_id'],
      title: json['title'],
      comment: json['comment'],
      rating: json['rating'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      product:
          json['product'] != null ? Product.fromJson(json['product']) : null,
    );
  }
}
