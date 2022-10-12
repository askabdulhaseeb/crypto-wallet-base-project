import 'package:flutter/material.dart';

import '../apis/wallet_api.dart';
import '../models/wallets/wallets.dart';
import '../utilities/local_data.dart';

class WalletProvider with ChangeNotifier {
  WalletProvider() {
    print('LocalData.getSeedPhrase');
    print(LocalData.getSeedPhrase);
    load(LocalData.getSeedPhrase);
  }
  List<Wallets> _wallets = <Wallets>[];
  List<Wallets> get wallets => _wallets;
  Future<bool> load(String seedid) async {
    bool temp = false;
    _wallets = await WalletsApi().get(seedid);
    temp = true;
    return temp;
  }
}
