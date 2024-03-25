import 'package:algeria_eats/core/utils/date_formatter.dart';
import 'package:algeria_eats/features/order/models/order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderComponent extends StatelessWidget {
  const OrderComponent({Key? key, required this.order, required this.onTap})
      : super(key: key);

  final Order order;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 5,
                offset: const Offset(0, 2),
              )
            ]),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  CupertinoIcons.cube_box,
                  size: 35,
                  color: Colors.grey.shade800,
                ),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "id: ${order.id}",
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "commandée le: ${DateFormattter.getFormattedDate(order.created_at)}",
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Produits :",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 5,
            ),
            Column(
              children: [
                for (var orderItem in order.orderItems)
                  Text(
                      "- ${orderItem.product.nom} x(${orderItem.quantity.toString()})  ${orderItem.product.prix * orderItem.quantity} DA"),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Adresse de livraison:",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
                "${order.adresse} ${order.commune} ${order.daira} ${order.wilaya}"),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Text(
                  "Total:",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "${order.orderItems.fold(0, (previousValue, element) => previousValue + element.quantity * element.product.prix)} DA",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.orange),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
