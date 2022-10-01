import 'package:flutter/cupertino.dart';

import '../models/coin_model.dart';

class CoinProvider with ChangeNotifier {
  List<CoinData> _coins = <CoinData>[];
  List<CoinData> get coins => _coins;
  getAllCoins(CoinData coinData) {
    _coins.add(coinData);
    notifyListeners();
  }
}
