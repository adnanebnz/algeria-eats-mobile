import 'package:algeria_eats/components/category_card_view.dart';
import 'package:flutter/material.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      height: MediaQuery.of(context).size.height * 0.22,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Categories",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  CategoryCardView(
                      title: 'Sucrée',
                      image: 'assets/images/sucree.jpg',
                      onTap: () {}),
                  CategoryCardView(
                      title: 'Salée',
                      image: 'assets/images/salee.jpg',
                      onTap: () {}),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
