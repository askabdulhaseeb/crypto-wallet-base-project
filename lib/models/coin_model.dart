class CoinData {
  CoinData({
    required this.name,
    required this.imageurl,
    required this.price,
    required this.daypercentage,
    required this.marketcaprank,
    required this.symbol,
    required this.weekpercentage,
  });
  final String name;
  final String symbol;
  final String imageurl;
  final double price;
  final double daypercentage;
  final double weekpercentage;
  final int marketcaprank;
}
