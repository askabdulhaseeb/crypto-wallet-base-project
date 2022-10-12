import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/balance_provider.dart';
import '../providers/coin_provider.dart';
import '../screens/bitcoin_transaction/tabbar.dart';
import '../screens/currency_screen/currency_full_screen.dart';

class CoinListView extends StatelessWidget {
  const CoinListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Balanceprovider>(
        builder: (context, Balanceprovider walletPro, snapshot) {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 60),
            child: Container(
              height: 40,
              child: Row(
                children: <Widget>[
                  const SizedBox(
                    width: 100,
                    child: Text('Name'),
                  ),
                  const SizedBox(
                    width: 80,
                    child: Text('Price'),
                  ),
                  Expanded(child: Container()),
                  const SizedBox(
                    width: 50,
                    child: Text('24%'),
                  ),
                  const SizedBox(
                    width: 60,
                    child: Text('7d%'),
                  ),
                ],
              ),
            ),
          ),
          walletPro.someCoins.isEmpty
              ? Center(child: const CircularProgressIndicator())
              : Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: walletPro.someCoins.length,
                      itemBuilder: (BuildContext context, int index) {
                        print(walletPro.someCoins.length);
                        print("walletPro.someCoins.length");

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CurrencyFullScreen(
                                    coinData: walletPro.someCoins[index],
                                    walletBalnce: walletPro.wallet[index]),
                              ),
                            );
                          },
                          child: Container(
                            height: 70,
                            width: double.infinity,
                            child: Row(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 20.0,
                                  backgroundImage: walletPro
                                          .someCoins[index].imageurl.isEmpty
                                      ? const NetworkImage(
                                          'https://assets.coingecko.com/coins/images/1/small/bitcoin.png?1547033579')
                                      : NetworkImage(
                                          walletPro.someCoins[index].imageurl),
                                  backgroundColor: Colors.white,
                                ),
                                const SizedBox(width: 20),
                                SizedBox(
                                  width: 100,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        walletPro.someCoins[index].name,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(walletPro
                                              .someCoins[index].marketcaprank
                                              .toString()),
                                          const SizedBox(width: 5),
                                          Text(walletPro
                                              .someCoins[index].symbol),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 80,
                                  child: Text(
                                      '\$ ${walletPro.someCoins[index].price.toStringAsFixed(2)}'),
                                ),
                                Expanded(child: Container()),
                                SizedBox(
                                  width: 50,
                                  child: Text(
                                    walletPro.someCoins[index].daypercentage
                                            .abs()
                                            .toStringAsFixed(2) +
                                        '%',
                                    style: TextStyle(
                                        color: walletPro.someCoins[index]
                                                .daypercentage.isNegative
                                            ? Colors.red
                                            : Colors.green),
                                  ),
                                ),
                                SizedBox(
                                  width: 60,
                                  child: Text(
                                    walletPro.someCoins[index].weekpercentage
                                            .abs()
                                            .toStringAsFixed(2) +
                                        '%',
                                    style: TextStyle(
                                        color: walletPro.someCoins[index]
                                                .weekpercentage.isNegative
                                            ? Colors.red
                                            : Colors.green),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
        ],
      );
    });
  }
}
