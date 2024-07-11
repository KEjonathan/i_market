// screens/category_items_page.dart
import 'package:flutter/material.dart';
import 'package:i_market/cart/cart_screen.dart';
import 'package:i_market/category/category_model.dart';
import 'package:i_market/items/item_model.dart';
import 'package:i_market/samples/data.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class CategoryItemsPage extends StatefulWidget {
  final Category category;

  const CategoryItemsPage({required this.category});

  @override
  _CategoryItemsPageState createState() => _CategoryItemsPageState();
}

class _CategoryItemsPageState extends State<CategoryItemsPage> {
  late List<Item> _items;
  String _searchQuery = '';
  bool _isAscending = true;

  @override
  void initState() {
    super.initState();
    _items = categoryItems[widget.category.name] ?? [];
  }

  void _filterItems() {
    setState(() {
      _items = categoryItems[widget.category.name]!
          .where((item) => item.name.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();

      if (!_isAscending) {
        _items.sort((a, b) => b.price.compareTo(a.price));
      } else {
        _items.sort((a, b) => a.price.compareTo(b.price));
      }
    });
  }

  void _toggleSortOrder() {
    setState(() {
      _isAscending = !_isAscending;
      _filterItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => CartScreen())
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                  _filterItems();
                });
              },
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(
                  _isAscending ? Icons.arrow_upward : Icons.arrow_downward,
                ),
                onPressed: _toggleSortOrder,
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Image.asset(
                      item.imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(item.name),
                    subtitle: Text('Price: \$${item.price}'),
                    trailing: IconButton(
                      icon: Icon(Icons.add_shopping_cart),
                      onPressed: () {
                        cart.addItem(item);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Added item to cart!'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
