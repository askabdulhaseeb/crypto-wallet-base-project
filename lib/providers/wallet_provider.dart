import 'package:flutter/material.dart';

import '../apis/wallet_api.dart';
import '../models/wallets/wallets.dart';

class WalletProvider with ChangeNotifier {
  WalletProvider() {
    load('afb08c4e-584b-46bd-a309-e94f31fda982');
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
