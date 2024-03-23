// ignore_for_file: file_names, avoid_print

import 'package:algeria_eats/core/errors/dio_exceptions.dart';
import 'package:algeria_eats/core/managers/dio_instance.dart';
import 'package:algeria_eats/core/utils/snackbar.dart';
import 'package:algeria_eats/features/products/models/product.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ProductController extends GetxController {
  RxList<Product> products = <Product>[].obs;
  RxList<Product> featuredProducts = <Product>[].obs;
  RxInt sweetProductsCount = 0.obs;
  RxInt saltyProductsCount = 0.obs;
  RxBool isLoading = true.obs;

  final dio = DioInstance.getDio();

  final PagingController<int, Product> pagingController =
      PagingController(firstPageKey: 0);

  RxString productType = "".obs;
  RxString search = "".obs;
  RxInt productRating = 0.obs;
  RxString orderDirection = "asc".obs;

  @override
  void onInit() {
    super.onInit();
    getFeaturedProducts();
    pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    });
  }

  @override
  void onClose() {
    products.clear();
    featuredProducts.clear();
    super.onClose();
  }

  Future<List<Product>> getAllProducts(int page) async {
    try {
      isLoading.value = true;
      final response = await dio.get(
        '/products',
        queryParameters: {
          'page': page,
          'productType': productType,
          'search': search,
          'productRating': productRating,
          'orderDirection': orderDirection,
        },
      );

      final responseData = response.data;

      final products = (responseData['products']['data'] as List<dynamic>)
          .map((productJson) {
        return Product.fromJson(productJson);
      }).toList();

      for (var product in products) {
        if (product.categorie == 'sucree') {
          sweetProductsCount.value++;
        } else {
          saltyProductsCount.value++;
        }
      }

      return products;
    } catch (e) {
      isLoading.value = false;
      if (e is DioExceptions) {
        ShowSnackBar.show(e.message, "error");
      } else {
        ShowSnackBar.show("Something wrong happened!", "error");
      }
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  Future getFeaturedProducts() async {
    try {
      isLoading.value = true;
      final response = await dio.get(
        '/products/featured',
      );

      final responseData = response.data;

      featuredProducts.value =
          (responseData['products'] as List<dynamic>).map((productJson) {
        return Product.fromJson(productJson);
      }).toList();
    } catch (e) {
      isLoading.value = false;
      if (e is DioExceptions) {
        ShowSnackBar.show(e.message, "error");
      } else {
        ShowSnackBar.show("Something wrong happened!", "error");
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchPage(int pageKey) async {
    try {
      final newItems = await getAllProducts(pageKey);
      final isLastPage = newItems.length < 10;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }
}
