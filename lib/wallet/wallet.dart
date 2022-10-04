import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';

import '../models/wallets/coin_wallet.dart';

class WallletWithApi {
  static String myWalletId = '';
  static String url = 'https://apirone.com/api/v2/wallets';
  List<String> units = ['btc', 'doge', 'bch', 'ltc'];

  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
  };
  Future<List<CoinsWallet>> createWallet() async {
    final List<CoinsWallet> coinsWallet = <CoinsWallet>[];
    String? endpointUrl = dotenv.env['ENDPOINT_URL'];
    for (String un in units) {
      Map<String, dynamic> body = <String, dynamic>{
        'type': 'saving',
        'currency': un,
        'callback': {
          'url': '${endpointUrl!}notifications-wallet.php',
        }
      };
      try {
        await http
            .post(Uri.parse(url),
                headers: requestHeaders, body: jsonEncode(body))
            .then((http.Response value) async {
          if (value.statusCode == 200) {
            var body = jsonDecode(value.body);

            String walletId = body['wallet'];
            String transferKey = body['transfer_key'];

            try {
              http.Response? addressResponse = await http
                  .post(
                Uri.parse('$url/$walletId/addresses'),
                headers: requestHeaders,
              )
                  .then((http.Response value) {
                if (value.statusCode == 200) {
                  var body = jsonDecode(value.body);
                  String address = body['address'];
                  // String encryptedAddress = (address);

                  // Map<String, dynamic> WalletData = {
                  //   '${un}_transfer_key': transferKey,
                  //   '${un}_wallet': walletId,
                  //   '${un}_address': address,
                  // };
                  // wallets.addAll(WalletData);
                  CoinsWallet coinInfo = CoinsWallet(
                    symble: un,
                    address: address,
                    transferKey: transferKey,
                    wallet: walletId,
                  );
                  coinsWallet.add(coinInfo);
                } else {
                  print('error');
                }
              }).timeout(
                const Duration(seconds: 60),
              );
              return addressResponse;
            } catch (e) {
              //print(e);
            }
          }
        }).timeout(
          const Duration(seconds: 60),
        );
      } catch (e) {
        // print(e);
      }
    }

    return coinsWallet;
  }

  var totalBalance;
  int i = 0;
  @override
  // ignore: always_specify_types
  Future<Map<String, dynamic>> getWalletBalance(List walletIds) async {
    Map<String, dynamic> balancesList = {};

    for (String walletId in walletIds) {
      String uni = walletId.substring(0, 3);
      String unit = uni == 'dog' ? 'doge' : uni;
      //print('walletIds $walletId');
      try {
        await http
            .get(
                Uri.parse(
                  '$url/$walletId/balance',
                ),
                headers: requestHeaders)
            .then((http.Response value) {
          if (value.statusCode == 200) {
            var body = jsonDecode(value.body);
            i++;

            // print('body $body');
            double available = ((body['available']) / 100000000.00);
            double total = ((body['total']) / 100000000.00);

            Map<String, double> balance = {
              'available': available,
              'total': total,
            };
            balancesList[unit] = (balance['available']);
          }
        }).timeout(
          const Duration(seconds: 30),
        );
      } catch (e) {
        print(e);
      }
    }
    totalBalance = balancesList['btc'];
    return balancesList;
  }

  Future<CoinsWallet?> createETherumWallet() async {
    try {
      EthereumAddress ethAdd;
      String privateKey = hexString(64);

      EthPrivateKey address = EthPrivateKey.fromHex(privateKey);
      ethAdd = await address.extractAddress();
      String add = ethAdd.toString();
      CoinsWallet coinInfo = CoinsWallet(
        symble: 'eth',
        address: add,
        transferKey: privateKey,
        wallet: '',
      );
      return coinInfo;
    } catch (e) {
      return null;
    }
  }

  static const String HEXCHARS = 'abcdef0123456789';
  String hexString(int strlen) {
    Random rnd = Random(DateTime.now().millisecondsSinceEpoch);
    String result = '';
    for (int i = 0; i < strlen; i++) {
      result += HEXCHARS[rnd.nextInt(HEXCHARS.length)];
    }
    return result;
  }
}
