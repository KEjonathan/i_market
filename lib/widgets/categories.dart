import 'package:flutter/material.dart';
import 'package:i_market/category/cat_details.dart';

class CategorySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Food Categories',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            CategoryCard(
              categoryName: 'Staples',
              imagePath: 'assets/images/potatoes.jpeg',
            ),
            CategoryCard(
              categoryName: 'Vegetables and Greens',
              imagePath: 'assets/images/vegetables.jpg',
            ),
            CategoryCard(
              categoryName: 'Meat and Fish',
              imagePath: 'assets/images/fish.jpg',
            ),
            CategoryCard(
              categoryName: 'Legumes and Pulses',
              imagePath: 'assets/images/grains.jpg',
            ),
            CategoryCard(
              categoryName: 'Snacks and Street Food',
              imagePath: 'assets/images/rolex.jpg',
            ),
            CategoryCard(
              categoryName: 'Fruits',
              imagePath: 'assets/images/fruits.jpg',
            ),
          ],
        ),
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String categoryName;
  final String imagePath;

  const CategoryCard({
    required this.categoryName,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                CategoryDetailsPage(categoryName: categoryName),
          ),
        );
      },
      child: Card(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned.fill(
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.black54,
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                child: Text(
                  categoryName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
