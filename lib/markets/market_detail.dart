import 'package:flutter/material.dart';
import 'package:i_market/category/cartegos.dart';
import 'package:i_market/markets/marketmodel.dart';

class MarketDetailsPage extends StatelessWidget {
  final Market market;

  const MarketDetailsPage({required this.market});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(market.name),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Market Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(
                market.imageUrl,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16.0),

            // Market Name
            Text(
              market.name,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.pink,
              ),
            ),
            SizedBox(height: 8.0),

            // Location
            Text(
              'Location: ${market.location}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 8.0),

            // Ratings
            Text(
              'Ratings: ${market.ratings.toStringAsFixed(1)} ★',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 8.0),

            // Discounts
            Text(
              'Discounts Offered: ${market.discount.toStringAsFixed(1)}%',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 8.0),

            // Distance
            Text(
              'Distance: ${market.distance.toStringAsFixed(2)} km',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 20.0),

            // Browse Categories Button
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CategoriesPage(),
                  ),
                );
              },
              child: Text('Browse Categories'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink, // Background color
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


