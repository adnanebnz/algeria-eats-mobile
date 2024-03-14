import 'package:algeria_eats/core/services/connectivity_service.dart';
import 'package:algeria_eats/features/artisans/views/artisans_screen.dart';
import 'package:algeria_eats/features/auth/controllers/auth_controller.dart';
import 'package:algeria_eats/features/home/views/home_screen.dart';
import 'package:algeria_eats/features/intro/views/on_board_screen.dart';
import 'package:algeria_eats/features/products/controllers/product_controller.dart';
import 'package:algeria_eats/features/products/views/products_screen.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shimmer/shimmer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<MainScreen> {
  ConnectivityService initServices = Get.find<ConnectivityService>();
  AuthController authController = Get.find<AuthController>();
  ProductController productController = Get.find<ProductController>();
  int _currentIndex = 0;
  late PageController _pageController;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: _currentIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          padding: const EdgeInsets.only(top: 12, left: 5, right: 5),
          child: AppBar(
            primary: true,
            leading: Builder(
              builder: (context) => GestureDetector(
                child: Icon(
                  FluentIcons.list_28_filled,
                  color: Colors.grey[800]!,
                  size: 28,
                ),
                onTap: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            centerTitle: true,
            title: GetStorage().read("location") != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Localisation actuelle",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 11,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/location.svg',
                            height: 16,
                            width: 16,
                            color: Colors.orange[600],
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.w500),
                              "${GetStorage().read('location')['city']}, ${GetStorage().read('location')['country']}"),
                        ],
                      ),
                    ],
                  )
                : const SizedBox(),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Obx(
                  () {
                    if (authController.isLoading.value) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.grey[300],
                        ),
                      );
                    } else {
                      return CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                          authController.user.value.image ??
                              'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
                        ),
                        backgroundColor: Colors.grey[300],
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle:
              const TextStyle(fontFamily: "POPPINS", fontSize: 12),
          selectedItemColor: const Color.fromRGBO(217, 119, 6, 1),
          enableFeedback: true,
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          items: [
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                'assets/images/home-alt.svg',
                height: 24,
                width: 24,
                color: const Color.fromRGBO(217, 119, 6, 1),
              ),
              icon: SvgPicture.asset(
                'assets/images/home-alt.svg',
                height: 24,
                width: 24,
              ),
              label: "Acceuil",
            ),
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                'assets/images/food.svg',
                height: 24,
                width: 24,
                color: const Color.fromRGBO(217, 119, 6, 1),
              ),
              icon: SvgPicture.asset(
                'assets/images/food.svg',
                height: 24,
                width: 24,
              ),
              label: "Produits",
            ),
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                'assets/images/chef-hat.svg',
                height: 24,
                width: 24,
                color: const Color.fromRGBO(217, 119, 6, 1),
              ),
              icon: SvgPicture.asset(
                'assets/images/chef-hat.svg',
                height: 24,
                width: 24,
              ),
              label: "Artisans",
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(251, 146, 60, 1),
              ),
              child: Obx(() {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(
                      () {
                        if (authController.isLoading.value) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.grey[300],
                            ),
                          );
                        } else {
                          return CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(
                              authController.user.value.image ??
                                  'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
                            ),
                            backgroundColor: Colors.grey[300],
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 8),
                    Text(
                      authController.user.value.nom,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      authController.user.value.prenom,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                leading: const Icon(Icons.shopping_bag_outlined),
                title: const Text('Mes achats'),
                onTap: () {
                  Get.toNamed("/user-orders");
                },
                tileColor: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                leading: const Icon(Icons.settings_outlined),
                title: const Text('Paramétres'),
                onTap: () {
                  //  TODO: Add Settings Page
                },
                tileColor: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                leading: const Icon(Icons.logout),
                title: const Text('Déconnexion'),
                onTap: () {
                  authController
                      .logout()
                      .then((value) => {Get.offAll(() => const OnBoardPage())});
                },
                tileColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Obx(() {
              return initServices.isConnected.value == false
                  ? Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                      ),
                      margin: const EdgeInsets.only(top: 7),
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Pas de Connection Internet",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.wifi_off_rounded,
                            color: Colors.white,
                          )
                        ],
                      ),
                    )
                  : const SizedBox();
            }),
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                children: [
                  const HomeScreen(),
                  ProductsScreen(),
                  const ArtisansScreen()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
