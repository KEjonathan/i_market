import 'package:flutter/material.dart';

class Vendor {
  final String name;
  final double rating;
  final String imageUrl;
  final String contact;

  Vendor({required this.name, required this.rating, required this.imageUrl, required this.contact});
}

class VendorsScreen extends StatelessWidget {
  final List<Vendor> vendors = [
    Vendor(name: 'Keisy K', rating: 4.5, imageUrl: 'assets/images/user.jpg', contact: '123-456-7890'),
    Vendor(name: 'Daniela P 2', rating: 4.0, imageUrl: 'assets/images/user.jpg', contact: '987-654-3210'),
    Vendor(name: 'Evelyn T', rating: 3.8, imageUrl: 'assets/images/user.jpg', contact: '555-666-7777'),
  ];

  void _showCheckoutDialog(BuildContext context, Vendor vendor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Checkout'),
          content: Text('Proceeding to checkout with ${vendor.name}'),
          actions: [
            TextButton(
              onPressed: () {
                // Clear the cart logic here
                // Navigate back to home screen
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select a Vendor'),
      ),
      body: ListView.builder(
        itemCount: vendors.length,
        itemBuilder: (context, index) {
          final vendor = vendors[index];
          return Card(
            child: ListTile(
              leading: Image.asset(vendor.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
              title: Text(vendor.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Rating: ${vendor.rating}'),
                  Text('Contact: ${vendor.contact}'),
                ],
              ),
              trailing: ElevatedButton(
                onPressed: () => _showCheckoutDialog(context, vendor),
                child: Text('Select'),
              ),
            ),
          );
        },
      ),
    );
  }
}
