import 'package:algeria_eats/components/loader.dart';
import 'package:algeria_eats/features/user_dashboard/controllers/user_orders_controller.dart';
import 'package:algeria_eats/features/user_dashboard/views/components/order_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserOrdersScreen extends GetView<UserOrdersController> {
  const UserOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(title: const Text('Mes Achats')),
          body: Column(
            children: [
              TabBar(
                indicatorColor: Colors.orange.shade300,
                dividerColor: Colors.grey[200],
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey[700],
                tabs: const [
                  Tab(text: 'En cours'),
                  Tab(text: 'Livré'),
                  Tab(text: 'Annulé'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 12),
                      child: Obx(() {
                        if (controller.isLoading.value) {
                          return const Center(
                            child: Loader(
                              size: 50,
                            ),
                          );
                        } else if (controller.orders.isEmpty) {
                          return const Center(
                              child: Text("Aucune commande trouvée"));
                        }
                        return ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 16,
                          ),
                          itemCount: controller.orders.length,
                          itemBuilder: (context, index) {
                            return OrderComponent(
                              onTap: () {
                                // NAVIGATE TO ORDER DETAILS
                              },
                              order: controller.orders[index],
                            );
                          },
                        );
                      }),
                    ),
                    const Text("hello"),
                    const Text("hello"),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
