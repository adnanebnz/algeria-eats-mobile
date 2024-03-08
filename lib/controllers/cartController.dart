import 'package:algeria_eats/models/cartItem.dart';
import 'package:algeria_eats/models/product.dart';
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

  void updateItem(Product product, int quantity) {
    int index = cartItems.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      cartItems[index].quantity = quantity;
      calculateTotal();
    }
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
