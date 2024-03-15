import 'package:algeria_eats/features/user_dashboard/controllers/user_orders_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserOrdersScreen extends GetView<UserOrdersController> {
  const UserOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Mes Achats')),
        body: const SafeArea(child: Text('HELLO')));
  }
}
