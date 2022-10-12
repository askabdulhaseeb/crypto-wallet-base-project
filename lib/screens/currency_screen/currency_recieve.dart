import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../models/coin_model.dart';
import '../../models/wallets/balance.dart';
import '../../wallet/wallet.dart';

class CurrencyRecieveScreen extends StatelessWidget {
  final CoinData coinData;
  final WalletBalnce walletBalnce;
  const CurrencyRecieveScreen(
      {super.key, required this.coinData, required this.walletBalnce});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recieve'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 16),
              QrImage(
                data: walletBalnce.address,
                version: QrVersions.auto,
                size: 120.0,
              ),
              const SizedBox(height: 16),
              Text(
                'Your ${coinData.name} Address :',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              const SizedBox(height: 16),

              Text(
                walletBalnce.address,
                //walletPro.walletadd,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              TextButton.icon(
                onPressed: () async {
                  await Clipboard.setData(
                      ClipboardData(text: walletBalnce.address));
                },
                icon: const Icon(Icons.copy),
                label: const Text('Copy Address'),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text(
                    'Your Balance : ',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  FutureBuilder<double>(
                      future: WallletWithApi()
                          .getWalletBalance(walletBalnce.address),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          double balance = snapshot.data! * coinData.price;
                          return Text(
                            '\$${balance.toStringAsFixed(3)}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          );
                        } else {
                          return snapshot.hasError
                              ? const Text('ERROR')
                              : const CircularProgressIndicator.adaptive();
                        }
                      }),
                ],
              ),
              // const SizedBox(height: 16),
              // TextButton(
              //   onPressed: () {},
              //   child: const Text(
              //     'Share',
              //     style: TextStyle(fontSize: 32),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
