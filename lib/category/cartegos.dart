// screens/categories_page.dart
import 'package:flutter/material.dart';
import 'package:i_market/category/category_model.dart';
import 'package:i_market/items/cat_item.dart';

class CategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Category> categories = [
      Category(name: 'Staples', imageUrl: 'assets/images/potatoes.jpg'),
      Category(name: 'Vegetables and Greens', imageUrl: 'assets/images/vegetables.jpg'),
      Category(name: 'Meat and Fish', imageUrl: 'assets/images/fish.jpg'),
      Category(name: 'Legumes and Pulses', imageUrl: 'assets/images/legumes.jpg'),
      Category(name: 'Snacks and Street Food', imageUrl: 'assets/images/rolex.jpg'),
      Category(name: 'Fruits', imageUrl: 'assets/images/fruits.jpg'),
      Category(name: 'Beverages', imageUrl: 'assets/images/beverages.jpg'),
      Category(name: 'Local Alcohols', imageUrl: 'assets/images/beverages.jpg'),
      Category(name: 'Dried', imageUrl: 'assets/images/grain.jpg'),
      Category(name: 'Dicotes', imageUrl: 'assets/images/staples2.jpg'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 1.2,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CategoryItemsPage(category: category),
                  ),
                );
              },
              child: CategoryCard(
                category: category,
              ),
            );
          },
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(
                category.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Text(
              category.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
