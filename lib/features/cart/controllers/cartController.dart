// ignore_for_file: file_names

import 'package:algeria_eats/features/cart/models/cartItem.dart';
import 'package:algeria_eats/features/products/models/product.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  RxDouble total = 0.0.obs;
  RxList<CartItem> cartItems = RxList<CartItem>();

  @override
  void onInit() {
    super.onInit();
    calculateTotal();
  }

  void calculateTotal() {
    total.value = cartItems.fold(
        0, (sum, item) => sum + item.product.prix * item.quantity);
  }

  void addItem(Product product, int quantity) {
    int index = cartItems.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      // If the product is already in the cart, increase its quantity
      cartItems[index].quantity++;
    } else {
      // If the product is not in the cart, add it
      cartItems.add(CartItem(product: product, quantity: quantity));
    }
    calculateTotal();
  }

  void removeItem(Product product) {
    cartItems.removeWhere((item) => item.product.id == product.id);
    calculateTotal();
  }

  void incrementQuantity(Product product) {
    int index = cartItems.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      cartItems[index].quantity++;
    }
    calculateTotal();
  }

  void decrementQuantity(Product product) {
    int index = cartItems.indexWhere((item) => item.product.id == product.id);
    if (index != -1 && cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
    }
    calculateTotal();
  }

  int getCartItemQuantity(Product product) {
    int index = cartItems.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      return cartItems[index].quantity;
    } else {
      return 0;
    }
  }

  @override
  void onClose() {
    cartItems.clear();
    total.value = 0.0;
  }
}
