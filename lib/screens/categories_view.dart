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
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Set crossAxisAlignment to start
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CategoryCardView(
                    text: 'Sucrée',
                    subtitle: '12 items',
                    imageUrl:
                        'https://static.vecteezy.com/system/resources/previews/023/522/885/non_2x/birthday-cake-cutout-free-png.png',
                    onPressed: () {},
                  ),
                  CategoryCardView(
                    text: 'Salée',
                    subtitle: '12 items',
                    imageUrl:
                        'https://static.vecteezy.com/system/resources/previews/021/217/138/non_2x/arabian-esfiha-of-chicken-esfirra-brazilian-snack-png.png',
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
