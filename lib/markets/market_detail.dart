import 'package:flutter/material.dart';

class MarketDetailsPage extends StatelessWidget {
  final String marketName;

  const MarketDetailsPage({required this.marketName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(marketName),
      ),
      body: Center(
        child: Text('Details for $marketName'),
      ),
    );
  }
}
