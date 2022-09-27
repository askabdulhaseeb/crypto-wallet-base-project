import 'dart:convert';

import '../../utilities/app_images.dart';

class Coin {
  Coin({
    required this.id,
    required this.name,
    required this.symbol,
    required this.image,
    required this.currentPrice,
    required this.totalVolume,
    required this.priceChange24H,
    required this.priceChangePercentage24H,
    required this.priceChangePercentage7D,
    required this.priceChangePercentage14D,
    required this.priceChangePercentage30D,
    required this.priceChangePercentage60D,
    required this.priceChangePercentage200D,
  });

  final String id;
  final String symbol;
  final String name;
  final String image;
  final double currentPrice;
  final int totalVolume;
  final double priceChange24H;
  final double priceChangePercentage24H;
  final double priceChangePercentage7D;
  final double priceChangePercentage14D;
  final double priceChangePercentage30D;
  final double priceChangePercentage60D;
  final double priceChangePercentage200D;

  // ignore: sort_constructors_first
  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      id: json['id'].toString(),
      symbol: json['symbol'],
      name: json['name'],
      image: json['image'] ??
          'data:image/jpeg;base64,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',
      // currentPrice: json['current_price'] + 0.0,
      currentPrice: 0.0,
      totalVolume: json['total_volume'] ?? 0,
      priceChange24H: json['price_change_24h'] ?? 0.0,
      priceChangePercentage24H: json['price_change_percentage_24h'] ?? 0.0,
      priceChangePercentage7D: json['price_change_percentage_7d'] ?? 0.0,
      priceChangePercentage14D: json['price_change_percentage_14d'] ?? 0.0,
      priceChangePercentage30D: json['price_change_percentage_30d'] ?? 0.0,
      priceChangePercentage60D: json['price_change_percentage_60d'] ?? 0.0,
      priceChangePercentage200D: json['price_change_percentage_200d'] ?? 0.0,
    );
  }

  static Coin fromMap(String str) => Coin.fromJson(json.decode(str));
}
