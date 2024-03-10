import 'package:algeria_eats/features/auth/views/login_screen.dart';
import 'package:algeria_eats/features/home/views/main_screen.dart';
import 'package:algeria_eats/features/intro/views/intro_screen.dart';
import 'package:algeria_eats/features/intro/views/on_board_screen.dart';
import 'package:get/get.dart';

class Routes {
  static List<GetPage> pages = [
    GetPage(
      name: '/home',
      page: () => const MainScreen(),
    ),
    GetPage(
      name: '/on-board',
      page: () => const OnBoardPage(),
    ),
    GetPage(name: "/intro", page: () => const IntroScreen()),
    GetPage(name: "/login", page: () => LoginScreen()),
    GetPage(name: "/main", page: () => const MainScreen()),
  ];
}
