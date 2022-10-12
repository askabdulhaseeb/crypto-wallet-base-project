import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/coin_model.dart';

class CoinGeckoApi {
  Future<List<CoinData>> getPrice() async {
    List<CoinData> coinDat = <CoinData>[];
    try {
      print('data in try');
      String temp;
      String url = 'https://api.coingecko.com/api/v3/coins';
      var response = await http.get(Uri.parse(url));
      var json = jsonDecode(response.body);
      for (int i = 0; i < json.length; i++) {
        CoinData coinData = CoinData(
          name: json[i]['name'] ?? '',
          daypercentage: json[i]['market_data']['price_change_percentage_24h']
                  .toDouble() ??
              0,
          imageurl: json[i]['image']['small'] ?? '',
          marketcaprank:
              json[i]['market_data']['market_cap_rank'].toDouble() ?? 0,
          price: json[i]['market_data']['current_price']['usd'].toDouble() ?? 0,
          symbol: json[i]['symbol'] ?? '',
          weekpercentage:
              json[i]['market_data']['price_change_percentage_7d'].toDouble() ??
                  0,
          totalsupply: json[i]['market_data']['total_supply'] ?? '',
          Circulationsupply: json[i]['market_data']['circulating_supply'] ?? '',
        );
        coinDat.add(coinData);
      }
      print('data loaded');

      //temp = json.toString();

      //var value = json['market_data']['current_price']['usd'].toString();
    } catch (e) {
      print(e.toString());
    }
    return coinDat;
  }
}
