import 'package:algeria_eats/controllers/authController.dart';
import 'package:algeria_eats/screens/home_screen.dart';
import 'package:algeria_eats/screens/on_board_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
// import 'dart:developer' as console show log;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<MainScreen> {
  final AuthController authController = Get.put(AuthController());
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    authController.me();
    _pageController = PageController(initialPage: _currentIndex);
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Acceuil",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
            child: Obx(
              () {
                if (authController.isLoading.value) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.grey[300],
                    ),
                  );
                } else {
                  return CircleAvatar(
                    radius: 22,
                    backgroundImage: NetworkImage(
                      '${authController.user['image'] ?? 'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'}',
                    ),
                    backgroundColor: Colors.grey[300],
                  );
                }
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.deepOrangeAccent,
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
                              '${authController.user['image'] ?? 'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'}',
                            ),
                            backgroundColor: Colors.grey[300],
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "${authController.user['nom'] ?? ''}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "${authController.user['prenom'] ?? ''}",
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
                leading: const Icon(Icons.logout),
                title: const Text('Deconnexion'),
                onTap: () {
                  authController.logout().then((value) => {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const OnBoardPage(),
                            ),
                            (route) => false)
                      });
                },
                tileColor: const Color.fromRGBO(229, 231, 235, 1),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: const [
            HomeScreen(),
            Center(child: Text('Search')),
            Center(child: Text('Profile')),
          ],
        ),
      ),
    );
  }
}
