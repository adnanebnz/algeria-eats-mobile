import 'package:algeria_eats/features/artisans/controllers/artisanController.dart';
import 'package:algeria_eats/features/auth/controllers/authController.dart';
import 'package:algeria_eats/features/cart/controllers/cartController.dart';
import 'package:algeria_eats/features/order/controllers/orderController.dart';
import 'package:algeria_eats/features/products/controllers/productController.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.lazyPut(() => CartController());
    Get.lazyPut(() => ProductController(), fenix: true);
    Get.lazyPut(() => ArtisanController(), fenix: true);
    Get.lazyPut(() => OrderController());
  }
}
