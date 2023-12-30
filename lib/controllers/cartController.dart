// ignore_for_file: file_names

import 'package:algeria_eats/models/cart.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  RxDouble total = 0.0.obs;
  RxList<CartItems> cartItems = RxList<CartItems>();

  addToCart(item) {
    cartItems.add(item);
    calculateTotal();
  }

  removeFromCart(item) {
    cartItems.remove(item);
    calculateTotal();
  }

  calculateTotal() {
    total.value = 0.0;
    for (var item in cartItems) {
      total.value += item.prix * item.quantity;
    }
    return total;
  }
}
