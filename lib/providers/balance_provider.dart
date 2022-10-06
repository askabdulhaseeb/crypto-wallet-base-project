import 'package:flutter/material.dart';
import '../models/wallets/balance.dart';
import '../wallet/wallet.dart';
import 'coin_provider.dart';
import 'wallet_provider.dart';

class Balanceprovider with ChangeNotifier {
  double totalBalnce = 890;
  double btcbalance = 10;
  double dogebalance = 10;
  double bchbalance = 10;
  double ltcbalance = 10;
  double get total => totalBalnce;
  List<WalletBalnce> _wallet = <WalletBalnce>[];
  List<WalletBalnce> get wallet => _wallet;
  void refresh(CoinProvider coinPro, WalletProvider walletPro) {
    if (walletPro.wallets.length == 1 && coinPro.coins.length == 50) {
      updateYourCoin(walletPro, coinPro);
      getAllBalance(walletPro, coinPro);
    }
    notifyListeners();
  }

  updateYourCoin(WalletProvider walletProvider, CoinProvider coinPro) async {
    wallet.clear();
    List<int> temp = coinApiIndex(coinPro);
    for (int i = 0; i < 4; i++) {
      print(coinPro.coins[temp[i]].name);
      WalletBalnce walletbal = WalletBalnce(
        name: coinPro.coins[temp[i]].name,
        // totalcoin: await WallletWithApi().getWalletBalance(
        //   walletProvider.wallets[0].coinsWallet[0].address),
        totalcoin: 1,
        address: walletProvider.wallets[0].coinsWallet[i].address,
        transferkey: walletProvider.wallets[0].coinsWallet[i].transferKey,
        wallet: walletProvider.wallets[0].coinsWallet[i].wallet,
        coinImage: coinPro.coins[temp[i]].imageurl,
        price: coinPro.coins[temp[i]].price,
      );
      _wallet.add(walletbal);
    }
  }

  List<int> coinApiIndex(CoinProvider coinPro) {
    List<int> temp = [];
    for (int i = 0; i < 50; i++) {
      if (coinPro.coins[i].symbol == 'btc') {
        temp.add(i);
      }
      if (coinPro.coins[i].symbol == 'doge') {
        temp.add(i);
      }
      if (coinPro.coins[i].symbol == 'bch') {
        temp.add(i);
      }
      if (coinPro.coins[i].symbol == 'ltc') {
        temp.add(i);
      }
    }
    return temp;
  }

  getAllBalance(WalletProvider walletProvider, CoinProvider coinPro) async {
    // btcbalance = await WallletWithApi().getWalletBalance(
    //         walletProvider.wallets[0].coinsWallet[0].address) *
    //     coinPro.coins[0].price;
    // dogebalance = await WallletWithApi().getWalletBalance(
    //         walletProvider.wallets[0].coinsWallet[1].address) *
    //     coinPro.coins[9].price;
    // bchbalance = await WallletWithApi().getWalletBalance(
    //         walletProvider.wallets[0].coinsWallet[2].address) *
    //     coinPro.coins[31].price;
    // ltcbalance = await WallletWithApi().getWalletBalance(
    //         walletProvider.wallets[0].coinsWallet[3].address) *
    //     coinPro.coins[20].price;
    //
    // Fake Money
    //
    btcbalance = 1 * coinPro.coins[0].price;
    dogebalance = 1 * coinPro.coins[9].price;
    bchbalance = 1 * coinPro.coins[31].price;
    ltcbalance = 1 * coinPro.coins[20].price;
    totalBalanceShow();
  }

  totalBalanceShow() {
    totalBalnce = bchbalance + btcbalance + dogebalance + ltcbalance;
    notifyListeners();
  }

  // double tempTotalBalanceShow() {
  //   totalBalnce = bchbalance + btcbalance + dogebalance + ltcbalance;
  //   return totalBalnce;
  // }
}
