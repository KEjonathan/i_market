import 'package:flutter/material.dart';
import 'package:i_market/cart/cart_screen.dart';
import 'package:i_market/widgets/app_drawer.dart';
import 'package:i_market/widgets/categories.dart';
import 'package:i_market/widgets/home_header.dart';
import 'package:i_market/widgets/market_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('iMarket'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => CartScreen() )
              );
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeHeader(),
            MarketSection(),
            CategorySection(),
          ],
        ),
      ),
    );
  }
}
