import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../providers/balance_provider.dart';
import '../../providers/coin_provider.dart';
import '../../providers/wallet_provider.dart';
import '../../wallet/wallet.dart';

class ReceiveBTCScreen extends StatefulWidget {
  const ReceiveBTCScreen({Key? key}) : super(key: key);

  @override
  State<ReceiveBTCScreen> createState() => _ReceiveBTCScreenState();
}

class _ReceiveBTCScreenState extends State<ReceiveBTCScreen> {
  @override
  void initState() {
    super.initState();
  }

  double balance = 0;
  // Future<void> getBalance() async {
  //   WalletProvider walletPro =
  //       Provider.of<WalletProvider>(context, listen: false);
  //   balance = await WallletWithApi().getWalletBalance(walletPro.walletsAddress);
  // }

  @override
  Widget build(BuildContext context) {
    WalletProvider walletPro = Provider.of<WalletProvider>(context);
    CoinProvider coinPro = Provider.of<CoinProvider>(context);
    Balanceprovider balancePro = Provider.of<Balanceprovider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 16),
              QrImage(
                data: walletPro.wallets[0].coinsWallet[0].address,
                version: QrVersions.auto,
                size: 120.0,
              ),
              const SizedBox(height: 16),
              const Text(
                'Your BTC Address :',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              const SizedBox(height: 16),
              // InkWell(
              //   onTap: () async {
              //     await Clipboard.setData(const ClipboardData(
              //       text: 'https://devmarkaz.com',
              //     )).then((_) =>
              //         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              //           content: Text('Copied to your clipboard !'),
              //         )));
              //   },
              //   borderRadius: BorderRadius.circular(12),
              //   child: Container(
              //     padding: const EdgeInsets.all(16),
              //     margin: const EdgeInsets.symmetric(vertical: 16),
              //     decoration: BoxDecoration(
              //       color: Colors.grey,
              //       borderRadius: BorderRadius.circular(12),
              //     ),
              //     alignment: Alignment.center,
              //     child: Row(
              //       children: <Widget>[
              //         const Flexible(
              //           child: Text(
              //             'https://devmarkaz.com',
              //             textAlign: TextAlign.center,
              //           ),
              //         ),
              //         IconButton(
              //           onPressed: () async {
              //             await Clipboard.setData(const ClipboardData(
              //               text: 'https://devmarkaz.com',
              //             )).then((_) => ScaffoldMessenger.of(context)
              //                     .showSnackBar(const SnackBar(
              //                   content: Text('Copied to your clipboard !'),
              //                 )));
              //           },
              //           splashRadius: 16,
              //           icon: const Icon(Icons.copy),
              //         )
              //       ],
              //     ),
              //   ),
              // ),

              Text(
                walletPro.wallets[0].coinsWallet[0].address,
                //walletPro.walletadd,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              TextButton.icon(
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(
                      text: walletPro.wallets[0].coinsWallet[0].address));
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
                      future: WallletWithApi().getWalletBalance(
                          walletPro.wallets[0].coinsWallet[0].address),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          double balance =
                              snapshot.data! * coinPro.coins[0].price;
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
