// ignore_for_file: file_names

import 'package:equatable/equatable.dart';
import 'package:algeria_eats/models/product.dart';

class CartItem extends Equatable {
  final Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});

  @override
  List<Object> get props => [product.id, quantity];
}
