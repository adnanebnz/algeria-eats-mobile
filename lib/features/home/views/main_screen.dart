import 'package:algeria_eats/components/custom_app_bar.dart';
import 'package:algeria_eats/components/custom_bottom_navigation_bar.dart';
import 'package:algeria_eats/components/custom_drawer.dart';
import 'package:algeria_eats/components/no_internet_connection.dart';
import 'package:algeria_eats/core/services/connectivity_service.dart';
import 'package:algeria_eats/features/artisans/views/artisans_screen.dart';
import 'package:algeria_eats/features/auth/controllers/auth_controller.dart';
import 'package:algeria_eats/features/home/views/home_screen.dart';
import 'package:algeria_eats/features/map/controllers/map_controller.dart';
import 'package:algeria_eats/features/map/views/map_screen.dart';
import 'package:algeria_eats/features/products/views/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<MainScreen> {
  ConnectivityService initServices = Get.find<ConnectivityService>();
  AuthController authController = Get.find<AuthController>();
  int _currentIndex = 0;
  late PageController pageController;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      pageController.jumpToPage(index);
    });
  }

  @override
  void initState() {
    pageController = PageController(initialPage: _currentIndex);
    pageController.addListener(() {
      if (pageController.page != 1) {
        Get.delete<MapController>();
      } else if (!Get.isRegistered<MapController>()) {
        Get.lazyPut(() => MapController(), fenix: true);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            Obx(() {
              return initServices.isConnected.value == false
                  ? const NoInternetConnectionComponent()
                  : const SizedBox();
            }),
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                children: const [
                  HomeScreen(),
                  MapScreen(),
                  ProductsScreen(),
                  ArtisansScreen()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
