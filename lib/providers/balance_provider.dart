import 'package:flutter/material.dart';
import 'coin_provider.dart';
import 'wallet_provider.dart';

class Balanceprovider with ChangeNotifier {
  double totalBalnce = 3500;
  double btcbalance = 10;
  double dogebalance = 10;
  double bchbalance = 10;
  double ltcbalance = 10;
  getAllBalance(WalletProvider walletProvider, CoinProvider coinPro) async {
    // btcbalance = await WallletWithApi().getWalletBalance(
    //         walletProvider.wallets[0].coinsWallet[0].address) *
    //     coinPro.coins[0].price;
    btcbalance = 1 * coinPro.coins[0].price;
    // dogebalance = await WallletWithApi().getWalletBalance(
    //         walletProvider.wallets[0].coinsWallet[1].address) *
    //     coinPro.coins[9].price;
    // bchbalance = await WallletWithApi().getWalletBalance(
    //         walletProvider.wallets[0].coinsWallet[2].address) *
    //     coinPro.coins[31].price;
    // ltcbalance = await WallletWithApi().getWalletBalance(
    //         walletProvider.wallets[0].coinsWallet[3].address) *
    //     coinPro.coins[20].price;
    dogebalance = 1 * coinPro.coins[9].price;
    bchbalance = 1 * coinPro.coins[31].price;
    ltcbalance = 1 * coinPro.coins[20].price;
    notifyListeners();
  }

  double totalBalanceShow() {
    totalBalnce = bchbalance + btcbalance + dogebalance + ltcbalance;
    return totalBalnce;
  }
}
