import 'package:flutter/material.dart';

import '../wallet/wallet.dart';
import 'wallet_provider.dart';

class Balanceprovider with ChangeNotifier {
  double totalBalnce = 3500;
  double btcbalance = 10;
  double dogebalance = 10;
  double bchbalance = 10;
  double ltcbalance = 10;
  getAllBalance(WalletProvider walletProvider) async {
    btcbalance = await WallletWithApi()
        .getWalletBalance(walletProvider.wallets[0].coinsWallet[0].address);
    dogebalance = await WallletWithApi()
        .getWalletBalance(walletProvider.wallets[0].coinsWallet[1].address);
    bchbalance = await WallletWithApi()
        .getWalletBalance(walletProvider.wallets[0].coinsWallet[2].address);
    ltcbalance = await WallletWithApi()
        .getWalletBalance(walletProvider.wallets[0].coinsWallet[3].address);
    notifyListeners();
  }

  double totalBalanceShow() {
    totalBalnce = bchbalance + btcbalance + dogebalance + ltcbalance;
    return totalBalnce;
  }
}
