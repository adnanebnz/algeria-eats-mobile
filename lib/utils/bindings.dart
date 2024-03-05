import 'package:algeria_eats/controllers/artisanController.dart';
import 'package:algeria_eats/controllers/authController.dart';
import 'package:algeria_eats/controllers/cartController.dart';
import 'package:algeria_eats/controllers/orderController.dart';
import 'package:algeria_eats/controllers/productController.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.lazyPut(() => CartController());
    Get.lazyPut(() => ProductController());
    Get.lazyPut(() => ArtisanController());
    Get.lazyPut(() => OrderController());
  }
}
