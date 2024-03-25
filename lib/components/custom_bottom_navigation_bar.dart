// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle:
            const TextStyle(fontFamily: "POPPINS", fontSize: 12),
        selectedItemColor: const Color.fromRGBO(217, 119, 6, 1),
        enableFeedback: true,
        currentIndex: currentIndex,
        onTap: onTap,
        items: [
          _buildItem('assets/images/home.svg', "Acceuil"),
          _buildItem('assets/images/map.svg', "Carte"),
          _buildItem('assets/images/store.svg', "Produits"),
          _buildItem('assets/images/chef-hat.svg', "Artisans"),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildItem(String assetPath, String label) {
    return BottomNavigationBarItem(
      activeIcon: SvgPicture.asset(
        assetPath,
        height: 24,
        width: 24,
        color: const Color.fromRGBO(217, 119, 6, 1),
      ),
      icon: SvgPicture.asset(
        assetPath,
        height: 24,
        width: 24,
      ),
      label: label,
    );
  }
}
