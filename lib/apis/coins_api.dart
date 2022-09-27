// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../models/coin_market_place/coin.dart';
import '../utilities/dome_data.dart';

class CoinsAPI {
  Future<List<Coin>> listingLatest() async {
    final Map<String, dynamic> data =
        json.decode(DomeData.listingLatest()) as Map<String, dynamic>;
    List<dynamic> coinsData = data['coinList'];
    List<Coin> coins = <Coin>[];
    for (dynamic element in coinsData) {
      coins.add(Coin.fromJson(element));
    }
    return coins;
  }
}
