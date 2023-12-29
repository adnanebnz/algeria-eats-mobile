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
  @override
  void initState() {
    authController.me();
    // TODO MAYBE REFRESH TOKEN
    super.initState();
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
              'https://placehold.co/100',
              fit: BoxFit.cover,
              height: 100,
              width: 100,
            ).image,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${authController.user['nom']} ${authController.user['prenom']}!",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      authController.user['email'] ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                );
              }),
            ),
            ListTile(
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
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: FeaturedProductsScreen(),
      ),
    );
  }
}
