import 'package:algeria_eats/core/errors/dio_exceptions.dart';
import 'package:algeria_eats/core/managers/dio_instance.dart';
import 'package:algeria_eats/core/utils/error_snackbar.dart';
import 'package:algeria_eats/features/order/models/order.dart';
import 'package:get/get.dart';

class UserOrdersController extends GetxController {
  RxList<Order> orders = <Order>[].obs;
  RxBool isLoading = false.obs;
  final dio = DioInstance.getDio();

  @override
  void onInit() {
    fetchUserOrders();
    super.onInit();
  }

  Future<void> fetchUserOrders() async {
    try {
      isLoading.value = true;
      final response = await dio.get(
        '/orders',
      );
      final responseData = response.data;
      orders.value = (responseData['orders'] as List<dynamic>).map((orderJson) {
        return Order.fromJson(orderJson);
      }).toList();
    } catch (e) {
      if (e is DioExceptions) {
        ErrorSnackBar.show(e.message, "error");
      } else {
        ErrorSnackBar.show("Something wrong happened!", "error");
      }
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    super.onClose();
    orders.clear();
  }
}
