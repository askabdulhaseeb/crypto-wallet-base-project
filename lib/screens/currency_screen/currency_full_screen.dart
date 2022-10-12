import 'package:flutter/material.dart';

import '../../models/coin_model.dart';
import '../../models/wallets/balance.dart';

class CurrencyFullScreen extends StatelessWidget {
  final CoinData coinData;
  final WalletBalnce walletBalnce;
  const CurrencyFullScreen(
      {super.key, required this.coinData, required this.walletBalnce});
  static const String routeName = '/currencyFullScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(coinData.name),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            Container(
              height: 30,
              width: 90,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(3)),
              child: Center(
                child: Text(
                  'Rank # ${coinData.marketcaprank}',
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 30.0,
              backgroundImage: coinData.imageurl.isEmpty
                  ? const NetworkImage(
                      'https://assets.coingecko.com/coins/images/1/small/bitcoin.png?1547033579')
                  : NetworkImage(coinData.imageurl),
              backgroundColor: Colors.white,
            ),
            const SizedBox(height: 20),
            Text(
              '${coinData.name}  (${coinData.symbol.toUpperCase()})',
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  '\$ ${coinData.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Text(
                  '${coinData.daypercentage.abs().toStringAsFixed(2)}%',
                  style: TextStyle(
                      fontSize: 18,
                      color: coinData.daypercentage.isNegative
                          ? Colors.red
                          : Colors.green),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Circulation Supply : ${coinData.Circulationsupply}',
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Total Supply : ${coinData.totalsupply}',
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            Expanded(child: Container()),
            Text(
              'Your Balance : ${walletBalnce.usdtPrice}',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(
                    width: 150,
                    child: ElevatedButton(
                        onPressed: () {}, child: const Text('Recieve'))),
                SizedBox(
                    width: 150,
                    child: ElevatedButton(
                        onPressed: () {}, child: const Text('Send'))),
              ],
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
