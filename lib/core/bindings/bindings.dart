import 'package:algeria_eats/core/services/connectivity_service.dart';
import 'package:algeria_eats/core/services/fcm_service.dart';
import 'package:algeria_eats/core/services/geolocation_service.dart';
import 'package:algeria_eats/features/artisans/controllers/artisan_controller.dart';
import 'package:algeria_eats/features/auth/controllers/auth_controller.dart';
import 'package:algeria_eats/features/cart/controllers/cart_controller.dart';
import 'package:algeria_eats/features/order/controllers/order_controller.dart';
import 'package:algeria_eats/features/products/controllers/product_controller.dart';
import 'package:algeria_eats/features/user_dashboard/controllers/user_orders_controller.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ConnectivityService());
    Get.put(FCMService());
    Get.put(GeoLocationService());
    Get.put(AuthController());
    Get.lazyPut(() => ProductController());
    Get.lazyPut(() => ArtisanController());
    Get.lazyPut(() => CartController());
    Get.lazyPut(() => OrderController());
    Get.lazyPut(() => UserOrdersController());
  }
}
