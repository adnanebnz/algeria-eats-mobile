import 'package:flutter/material.dart';

class NoInternetConnectionComponent extends StatelessWidget {
  const NoInternetConnectionComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
