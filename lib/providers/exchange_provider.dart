import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import '../models/swapable_coin.dart';
import '../utilities/dome_data.dart';
import '../widget/custom_widgets/custom_toast.dart';

class ExchangeCoinProvider extends ChangeNotifier {
  //
  // Variables
  //
  SwapableCoin? _from;
  SwapableCoin? _to;

  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();

  List<SwapableCoin> _coins = <SwapableCoin>[];

  double _fromBalance = 0;
  double _swapPrice = 0;
  double _priceImpact = 0;
  double _minimumIn = 0;

  int _lastTap = 0;

  String _error = '';

  //
  // Getter
  //

  SwapableCoin? get from => _from;
  SwapableCoin? get to => _to;

  TextEditingController get fromController => _fromController;
  TextEditingController get toController => _toController;

  List<SwapableCoin> get swapableCoins => <SwapableCoin>[..._coins];

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

  onFromCoinChange(SwapableCoin? value) async {
    _from = value;
    _initCoins();
    onFromControllerChange(_fromController.text);
    log('start'); // result -> API
    // _to = result ;
  }

  onToCoinChange(SwapableCoin? value) {
    _to = value;
    _initCoins();
    onFromControllerChange(_fromController.text);
  }

  exhcange() async {
    //
    // Approve Token
    // if BNB then no approve
    log('Start Exchange');
    String hash = '';
    if (_from!.symbol.toUpperCase() != 'BNB') {
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
    final Map<String, dynamic> data =
        json.decode(DomeData.listingLatest()) as Map<String, dynamic>;
    List<dynamic> coinsData = data['coinList'];
    List<SwapableCoin> coins = <SwapableCoin>[];
    for (dynamic element in coinsData) {
      coins.add(SwapableCoin.fromJson(element));
    }
    _coins = coins;
    _from = coins[0];
    _to = coins[2];
    if (_coins.isNotEmpty) return;
    if (_from == null) {
      final int fIndex = _coins.indexWhere(
          (SwapableCoin element) => element.symbol.toUpperCase() == 'BNB');
      _from = fIndex < 0 ? _coins[0] : _coins[fIndex];
    } else if (_from == _to) {
      final int fIndex = _coins
          .indexWhere((SwapableCoin element) => element.symbol != _to?.symbol);
      _from = _coins[fIndex];
    }
    if (_to == null) {
      final int sIndex = _coins.indexWhere(
          (SwapableCoin element) => element.symbol.toUpperCase() == 'MINU');
      _to = sIndex < 0 ? _coins[1] : _coins[sIndex];
    } else if (_to == _from) {
      final int sIndex = _coins.indexWhere(
          (SwapableCoin element) => element.symbol != _from?.symbol);
      _to = _coins[sIndex];
    }
    notifyListeners();
  }
}
