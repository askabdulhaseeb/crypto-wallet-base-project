import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/coin_provider.dart';

class CoinListView extends StatelessWidget {
  const CoinListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CoinProvider>(
        builder: (context, CoinProvider coinPro, snapshot) {
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
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: coinPro.coins.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 70,
                    width: double.infinity,
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 20.0,
                          backgroundImage: coinPro.coins[index].imageurl.isEmpty
                              ? const NetworkImage(
                                  'https://assets.coingecko.com/coins/images/1/small/bitcoin.png?1547033579')
                              : NetworkImage(coinPro.coins[index].imageurl),
                          backgroundColor: Colors.white,
                        ),
                        const SizedBox(width: 20),
                        SizedBox(
                          width: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                coinPro.coins[index].name,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(coinPro.coins[index].marketcaprank
                                      .toString()),
                                  const SizedBox(width: 5),
                                  Text(coinPro.coins[index].symbol),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          child: Text(
                              '\$ ${coinPro.coins[index].price.toStringAsFixed(2)}'),
                        ),
                        Expanded(child: Container()),
                        SizedBox(
                          width: 50,
                          child: Text(
                            coinPro.coins[index].daypercentage
                                    .abs()
                                    .toStringAsFixed(2) +
                                '%',
                            style: TextStyle(
                                color: coinPro
                                        .coins[index].daypercentage.isNegative
                                    ? Colors.red
                                    : Colors.green),
                          ),
                        ),
                        SizedBox(
                          width: 60,
                          child: Text(
                            coinPro.coins[index].weekpercentage
                                    .abs()
                                    .toStringAsFixed(2) +
                                '%',
                            style: TextStyle(
                                color: coinPro
                                        .coins[index].weekpercentage.isNegative
                                    ? Colors.red
                                    : Colors.green),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
      );
    });
  }
}
