import 'package:algeria_eats/views/home_screen.dart';
import 'package:algeria_eats/views/intro_screen.dart';
import 'package:algeria_eats/views/on_board_screen.dart';
import 'package:get/get.dart';

class Routes {
  static List<GetPage> pages = [
    GetPage(
      name: '/home',
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: '/on-board',
      page: () => const OnBoardPage(),
    ),
    GetPage(name: "/intro", page: () => const IntroScreen())
  ];
}
