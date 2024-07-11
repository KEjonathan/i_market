import 'package:flutter/material.dart';
import 'package:i_market/markets/market_detail.dart';

class MarketSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final markets = [
      {'name': 'Owino Market', 'image': 'assets/images/market1.jpg'},
      {'name': 'Nakasero Market', 'image': 'assets/images/market2.jpg'},
      {'name': 'Gulu Main Market', 'image': 'assets/images/market3.jpg'},
      {'name': 'Mbale Main Market', 'image': 'assets/images/market4.jpg'},
      {'name': 'Mbarara Main Market', 'image': 'assets/images/market1.jpg'},
      {'name': 'Kasese Main Market', 'image': 'assets/images/market2.jpg'},
      {'name': 'Masaka Main Market', 'image': 'assets/images/market3.jpg'},
      {'name': 'Jinja Main Market', 'image': 'assets/images/market4.jpg'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Markets',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: markets.length,
            itemBuilder: (context, index) {
              final market = markets[index];
              return Container(
                width: MediaQuery.of(context).size.width / 2,
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: MarketCard(
                  marketName: market['name']!,
                  imagePath: market['image']!,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class MarketCard extends StatelessWidget {
  final String marketName;
  final String imagePath;

  const MarketCard({
    required this.marketName,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MarketDetailsPage(marketName: marketName),
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
            Center(
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  marketName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
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
