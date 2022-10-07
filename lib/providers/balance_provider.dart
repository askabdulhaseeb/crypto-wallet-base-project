import 'package:flutter/material.dart';
import '../models/wallets/balance.dart';
import '../wallet/wallet.dart';
import '../widget/custom_widgets/custom_toast.dart';
import 'coin_provider.dart';
import 'wallet_provider.dart';
import 'dart:convert';
import 'dart:developer';

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
  //exchange Provider
  //
  // Variables
  //
  WalletBalnce? _from;
  WalletBalnce? _to;

  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();

  List<WalletBalnce> _coins = <WalletBalnce>[];
  List<WalletBalnce> get coins => _coins;
  double _fromBalance = 0;
  double _swapPrice = 0;
  double _priceImpact = 0;
  double _minimumIn = 0;

  int _lastTap = 0;

  String _error = '';

  //
  // Getter
  //

  WalletBalnce? get from => _from;
  WalletBalnce? get to => _to;

  TextEditingController get fromController => _fromController;
  TextEditingController get toController => _toController;

  List<WalletBalnce> get WalletBalnces => <WalletBalnce>[..._coins];

  double get fromCoinBalance => _fromBalance;
  double get swapPrice => _swapPrice;
  double get priceImpact => _priceImpact;
  double get minimumIn => _minimumIn;

  String get error => _error;

  Future<bool> init() async {
    if (_coins.isNotEmpty) return true;
    await _load();
    return true;
  }

  onFromControllerChange(String? value) async {
    if (value == null || value.isEmpty || double.parse(value) == 0) {
      _reset();
      return;
    }
    if (_completeWriting()) return;
    log('start');
  }

  Future<void> onToControllerChange(String? value) async {
    if (value == null || value.isEmpty || double.parse(value) == 0) {
      _reset();
      return;
    }
    if (_completeWriting()) return;
    log('start');
  }

  onFromCoinChange(WalletBalnce? value) async {
    _from = value;
    _initCoins();
    onFromControllerChange(_fromController.text);
    log('start'); // result -> API
    // _to = result ;
  }

  onToCoinChange(WalletBalnce? value) {
    _to = value;
    _initCoins();
    onToControllerChange(_toController.text);
  }

  exhcange() async {
    //
    // Approve Token
    // if BNB then no approve
    log('Start Exchange');
    String hash = '';
    if (_from!.name.toUpperCase() != 'BNB') {
      // ignore: unnecessary_nullable_for_final_variable_declarations
      const Map<String, dynamic>? approveTokenMap = <String, dynamic>{};
      log('Approvel end');
      // ignore: unnecessary_null_comparison
      if (approveTokenMap == null) return;
      if (approveTokenMap['status'] == false) {
        _error = approveTokenMap['message'];
      }

      hash = approveTokenMap['hash'];
      log('Hash: $hash');
      log('Confirm: true');
    }
    //
    // Approve Token Done
    //
    const Map<String, dynamic> tokenSwapMap = <String, dynamic>{
      'success': true
    };
    if (tokenSwapMap['success'] ?? false == true) {
      _reset();
      CustomToast.successToast(message: 'Swapping Complete');
    }
  }

  String? fromValidator(String? value) {
    if (value == null || value == '0') {
      return 'Enter amount here';
    }
    final double entered = double.parse(value);
    if (entered > _fromBalance) {
      return '''You don't have much balance''';
    }
    return null;
  }

  _load() async {
    log('load');

    _initCoins();
  }

  _reset() {
    _fromController.clear();
    _toController.clear();
    _fromBalance = 0;
    _swapPrice = 0;
    _priceImpact = 0;
    _minimumIn = 0;
    notifyListeners();
  }

  bool _completeWriting() {
    int now = DateTime.now().millisecondsSinceEpoch;
    if (now - _lastTap < 1000) {
      return true;
    }
    _lastTap = now;
    return false;
  }

  // _assignValues(Map<String, dynamic>? map, bool isFirstValue) {
  //   _swapPrice = double.parse(map?['swapPrice'] ?? '0.0');
  //   _priceImpact = double.parse(map?['priceImpact'] ?? '0.0');
  //   _minimumIn = double.parse(map?['minimumIn']?.toString() ?? '0.0');
  //   notifyListeners();
  //   if (!isFirstValue) {
  //     _fromController.text = map?['amount1'] ?? '0.0';
  //   } else {
  //     _toController.text = map?['amount2'] ?? '0.0';
  //   }
  // }
    _assignValues(Map<String, dynamic>? map, bool isFirstValue) {
    _swapPrice = double.parse(map?['swapPrice'] ?? '0.0');
    _priceImpact = double.parse(map?['priceImpact'] ?? '0.0');
    _minimumIn = double.parse(map?['minimumIn']?.toString() ?? '0.0');
    notifyListeners();
    if (!isFirstValue) {
      _fromController.text = map?['amount1'] ?? '0.0';
    } else {
      _toController.text = map?['amount2'] ?? '0.0';
    }
  }
  _initCoins() {
    List<WalletBalnce> coins = wallet;

    _coins = coins;
    _from = coins[0];
    _to = coins[2];
    if (_coins.isNotEmpty) return;
    if (_from == null) {
      final int fIndex = _coins.indexWhere(
          (WalletBalnce element) => element.name.toUpperCase() == 'BNB');
      _from = fIndex < 0 ? _coins[0] : _coins[fIndex];
    } else if (_from == _to) {
      final int fIndex = _coins
          .indexWhere((WalletBalnce element) => element.name != _to?.name);
      _from = _coins[fIndex];
    }
    if (_to == null) {
      final int sIndex = _coins.indexWhere(
          (WalletBalnce element) => element.name.toUpperCase() == 'MINU');
      _to = sIndex < 0 ? _coins[1] : _coins[sIndex];
    } else if (_to == _from) {
      final int sIndex = _coins
          .indexWhere((WalletBalnce element) => element.name != _from?.name);
      _to = _coins[sIndex];
    }
    notifyListeners();
  }
}
