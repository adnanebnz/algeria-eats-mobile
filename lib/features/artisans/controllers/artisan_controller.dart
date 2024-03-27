import 'package:algeria_eats/core/errors/dio_exceptions.dart';
import 'package:algeria_eats/core/managers/dio_instance.dart';
import 'package:algeria_eats/core/utils/snackbar.dart';
import 'package:algeria_eats/features/artisans/models/artisan.dart';
import 'package:algeria_eats/features/auth/controllers/auth_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ArtisanController extends GetxController {
  RxList<Artisan> neirestArtisans = <Artisan>[].obs;
  RxList<Artisan> artisans = <Artisan>[].obs;
  RxBool isLoading = false.obs;
  RxString search = "".obs;
  RxInt artisanRating = 0.obs;
  RxString typeService = "".obs;
  RxString artisanWilaya = "".obs;

  final dio = DioInstance.getDio();
  final PagingController<int, Artisan> pagingController =
      PagingController(firstPageKey: 0);

  set setArtisanName(String value) => search.value = value;

  @override
  void onInit() {
    super.onInit();
    getAllArtisans();
    pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    });
    getNeirestArtisans();
  }

  @override
  void onReady() {
    super.onReady();
    debounce(
      search,
      (value) {
        search.value = value;
        pagingController.refresh();
      },
      time: const Duration(milliseconds: 800),
    );
  }

  @override
  void onClose() {
    pagingController.dispose();

    super.onClose();
  }

  Future<void> fetchPage(int pageKey) async {
    try {
      final newArtisans = await getArtisans(pageKey);
      final isLastPage = newArtisans.length < 10;
      if (isLastPage) {
        pagingController.appendLastPage(newArtisans);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(newArtisans, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  Future<List<Artisan>?> getNeirestArtisans() async {
    try {
      isLoading.value = true;
      final response = await dio.get('/neirest-artisans',
          data: {"user_id": Get.find<AuthController>().user.value.id});

      final responseData = response.data;
      neirestArtisans.value = (responseData['artisans'] as List<dynamic>)
          .map((artisanJson) =>
              Artisan.fromJson(artisanJson as Map<String, dynamic>))
          .toList();

      isLoading.value = false;
      return neirestArtisans;
    } catch (e) {
      if (kDebugMode) {
        printError(info: e.toString());
      }
    } finally {
      isLoading.value = false;
    }
    return null;
  }

  Future<List<Artisan>> getArtisans(int page) async {
    try {
      isLoading.value = true;
      final response = await dio.get(
        '/artisans',
        queryParameters: {
          'page': page,
          'artisanWilaya': artisanWilaya,
          'search': search,
          'artisanRating': artisanRating,
          'typeService': typeService,
        },
      );

      final responseData = response.data;

      final artisansRes = (responseData['artisans']['data'] as List<dynamic>)
          .map((artisanJson) =>
              Artisan.fromJson(artisanJson as Map<String, dynamic>))
          .toList();

      return artisansRes;
    } catch (e) {
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

  Future<void> getAllArtisans() async {
    try {
      isLoading.value = true;
      final response = await dio.get(
        '/all-artisans',
      );

      final responseData = response.data;

      artisans.value = (responseData['artisans'] as List<dynamic>)
          .map((artisanJson) =>
              Artisan.fromJson(artisanJson as Map<String, dynamic>))
          .toList();
    } catch (e) {
      if (e is DioExceptions) {
        ShowSnackBar.show(e.message, "error");
      } else {
        ShowSnackBar.show("Something wrong happened!", "error");
      }
    } finally {
      isLoading.value = false;
    }
  }
}
