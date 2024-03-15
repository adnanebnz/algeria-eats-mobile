// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:algeria_eats/features/products/models/product.dart';

class CartItem extends Equatable {
  final Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});

  @override
  List<Object> get props => [product.id, quantity];
}
