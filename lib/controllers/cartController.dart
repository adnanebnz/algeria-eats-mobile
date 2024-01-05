// ignore_for_file: file_names

import 'package:algeria_eats/models/cartItem.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  RxDouble total = 0.0.obs;
  RxList<CartItem> cartItems = RxList<CartItem>();

  addToCart(item) {
    if (cartItems.contains(item)) {
      return;
    }
    cartItems.add(item);
    calculateTotal();
  }

  incrementItem(item) {
    if (cartItems.contains(item)) {
      item.quantity++;
      calculateTotal();
    }
  }

  getCartItemQuantity(item) {
    if (cartItems.contains(item)) {
      return item.quantity;
    }
    return 0;
  }

  decrementItem(item) {
    if (cartItems.contains(item)) {
      if (item.quantity > 1) item.quantity--;
      calculateTotal();
    }
  }

  removeFromCart(item) {
    cartItems.remove(item);
    calculateTotal();
  }

  calculateTotal() {
    total.value = 0.0;
    for (var item in cartItems) {
      total.value += item.product.prix * item.quantity;
    }
    return total;
  }
}
