// ignore_for_file: file_names

import 'package:algeria_eats/models/product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartItem &&
        other.product.id ==
            product.id; // Use a unique identifier like product ID
  }

  @override
  int get hashCode =>
      product.id.hashCode; // Use a unique identifier like product ID
}
