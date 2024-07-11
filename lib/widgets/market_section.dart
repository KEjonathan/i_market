import 'package:flutter/material.dart';
import 'package:i_market/markets/market_detail.dart';
import 'package:i_market/markets/marketmodel.dart';

class MarketSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
final List<Market> markets = [
  Market(
    name: 'Owino Market',
    imageUrl: 'assets/images/market1.jpg',
    location: 'Kampala',
    ratings: 4.5,
    discount: 10.0,
    distance: 1.2,
  ),
  Market(
    name: 'Nakasero Market',
    imageUrl: 'assets/images/market2.jpg',
    location: 'Kampala',
    ratings: 4.0,
    discount: 5.0,
    distance: 2.5,
  ),
  Market(
    name: 'Gulu Main Market',
    imageUrl: 'assets/images/market3.jpg',
    location: 'Gulu',
    ratings: 4.2,
    discount: 8.0,
    distance: 50.0,
  ),
  Market(
    name: 'Mbale Main Market',
    imageUrl: 'assets/images/market4.jpg',
    location: 'Mbale',
    ratings: 3.8,
    discount: 7.0,
    distance: 120.0,
  ),
  Market(
    name: 'Mbarara Main Market',
    imageUrl: 'assets/images/market1.jpg',
    location: 'Mbarara',
    ratings: 4.1,
    discount: 6.0,
    distance: 80.0,
  ),
  Market(
    name: 'Kasese Main Market',
    imageUrl: 'assets/images/market2.jpg',
    location: 'Kasese',
    ratings: 4.0,
    discount: 9.0,
    distance: 100.0,
  ),
  Market(
    name: 'Masaka Main Market',
    imageUrl: 'assets/images/market3.jpg',
    location: 'Masaka',
    ratings: 3.9,
    discount: 4.0,
    distance: 90.0,
  ),
  Market(
    name: 'Jinja Main Market',
    imageUrl: 'assets/images/market4.jpg',
    location: 'Jinja',
    ratings: 4.3,
    discount: 11.0,
    distance: 75.0,
  ),
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
                child: MarketCard(market: market),
              );
            },
          ),
        ),
      ],
    );
  }
}

class MarketCard extends StatelessWidget {
  final Market market;

  const MarketCard({
    required this.market,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MarketDetailsPage(market: market),
          ),
        );
      },
      child: Card(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned.fill(
              child: Image.asset(
                market.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  market.name,
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
