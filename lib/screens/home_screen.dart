import 'package:algeria_eats/controllers/authController.dart';
import 'package:algeria_eats/screens/featured_products_screen.dart';
import 'package:algeria_eats/screens/on_board_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<HomeScreen> {
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
        title: Obx(() {
          return Text(
            "Bienvenu ${authController.user['prenom'] ?? ''}",
            style: const TextStyle(
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          );
        }),
        actions: [
          CircleAvatar(
            backgroundImage: Image.network(
              '${authController.user['image'] ?? 'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'}',
              fit: BoxFit.cover,
              height: 100,
              width: 100,
            ).image,
          ),
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
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: Image.network(
                        '${authController.user['image'] ?? 'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'}',
                        fit: BoxFit.cover,
                      ).image,
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
          children: [
            FeaturedProductsScreen(),
            const Center(child: Text('Search')),
            const Center(child: Text('Profile')),
          ],
        ),
      ),
    );
  }
}
