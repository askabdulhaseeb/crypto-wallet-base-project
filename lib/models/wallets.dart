class Wallets {
  Wallets({
    required this.walletId,
    required this.userid,
    required this.seedid,
    required this.walletAddMap,
  });
  final String userid;
  final String seedid;
  final String walletId;
  Map<String, dynamic> walletAddMap;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': userid,
      'seed_id': seedid,
      'wallet_id': walletId,
      'Wallets': walletAddMap,
    };
  }
}
