import 'package:flutter/cupertino.dart';

import '../apis/coingecko_api.dart';
import '../models/coin_model.dart';

class CoinProvider with ChangeNotifier {
  CoinProvider() {
    getAllCoins();
  }
  List<CoinData> _coins = <CoinData>[];
  List<CoinData> get coins => _coins;
  Future<void> getAllCoins() async {
    _coins = await CoinGeckoApi().getPrice();
  
    notifyListeners();
  }

  
}
