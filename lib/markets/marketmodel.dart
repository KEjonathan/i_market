import 'package:google_maps_flutter/google_maps_flutter.dart'; // Optional for maps

class Market {
  final String name;
  final String imageUrl;
  final String location;
  final double ratings;
  final double discount;
  final double distance;

  Market({
    required this.name,
    required this.imageUrl,
    required this.location,
    required this.ratings,
    required this.discount,
    required this.distance,
  });

  // Factory method to create a Market from a Map
  factory Market.fromMap(Map<String, dynamic> map) {
    return Market(
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      location: map['location'] ?? '',
      ratings: (map['ratings'] ?? 0.0).toDouble(),
      discount: (map['discount'] ?? 0.0).toDouble(),
      distance: (map['distance'] ?? 0.0).toDouble(),
    );
  }

  // Method to convert a Market to a Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'location': location,
      'ratings': ratings,
      'discount': discount,
      'distance': distance,
    };
  }
}
