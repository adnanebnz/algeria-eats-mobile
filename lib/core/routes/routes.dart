import 'package:algeria_eats/features/auth/views/login_screen.dart';
import 'package:algeria_eats/features/auth/views/register_screen.dart';
import 'package:algeria_eats/features/home/views/main_screen.dart';
import 'package:algeria_eats/features/intro/views/intro_screen.dart';
import 'package:algeria_eats/features/intro/views/on_board_screen.dart';
import 'package:algeria_eats/features/order/views/order_error_screen.dart';
import 'package:algeria_eats/features/order/views/order_success_screen.dart';
import 'package:algeria_eats/features/user_dashboard/views/user_orders_screen.dart';
import 'package:get/get.dart';

class Routes {
  static List<GetPage> pages = [
    GetPage(
      name: '/on-board',
      page: () => const OnBoardPage(),
    ),
    GetPage(name: "/intro", page: () => const IntroScreen()),
    GetPage(name: "/login", page: () => LoginScreen()),
    GetPage(name: "/register", page: () => RegisterScreen()),
    GetPage(name: "/main", page: () => const MainScreen()),
    GetPage(name: "/order-success", page: () => const OrderSuccessScreen()),
    GetPage(name: "/order-error", page: () => const OrderErrorScreen()),
    GetPage(name: "/user-orders", page: () => const UserOrdersScreen())
  ];
}
