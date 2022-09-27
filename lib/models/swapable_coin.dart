class SwapableCoin {
  SwapableCoin({
    required this.id,
    required this.symbol,
    required this.name,
    required this.contractAddress,
    required this.testContractAddress,
    required this.image,
    required this.createdAt,
    required this.isActive,
  });
  final int id;
  final String symbol;
  final String name;
  final String contractAddress;
  final String? testContractAddress;
  final String? image;
  final DateTime createdAt;
  final int isActive;

  // ignore: sort_constructors_first
  factory SwapableCoin.fromJson(Map<String, dynamic> json) => SwapableCoin(
        id: json['id'],
        symbol: json['symbol'] ?? 'BNB',
        name: json['name'] ?? 'null',
        contractAddress: json['contract_address'] ?? 'null',
        testContractAddress: json['test_contract_address'] ?? 'null',
        image: json['image'] ?? '',
        createdAt: DateTime.parse(json['created_at'] ?? DateTime.now()),
        isActive: json['isActive'] ?? true,
      );
}
