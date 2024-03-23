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
    Get.put(ConnectivityService(), permanent: true);
    Get.put(FCMService(), permanent: true);
    Get.put(GeoLocationService(), permanent: true);
    Get.put(AuthController(), permanent: true);
    Get.lazyPut(() => ProductController());
    Get.lazyPut(() => ArtisanController());
    Get.lazyPut(() => CartController(), fenix: true);
    Get.lazyPut(() => OrderController());
    Get.lazyPut(() => UserOrdersController());
  }
}
