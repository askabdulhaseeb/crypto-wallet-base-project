import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/coin_provider.dart';
import '../../providers/wallet_provider.dart';
import '../../wallet/wallet.dart';
import '../../widget/custom_widgets/custom_toast.dart';

class SendBitcoinScreen extends StatefulWidget {
  const SendBitcoinScreen({Key? key}) : super(key: key);

  @override
  State<SendBitcoinScreen> createState() => _SendBitcoinScreenState();
}

class _SendBitcoinScreenState extends State<SendBitcoinScreen> {
  final TextEditingController _walletaddress = TextEditingController();
  final TextEditingController _amount = TextEditingController();
  btcSend() async {
    WalletProvider walletPro =
        Provider.of<WalletProvider>(context, listen: false);
    CoinProvider coinPro = Provider.of<CoinProvider>(context, listen: false);
    String temp = _amount.text;
    double amountt = double.parse(temp);
    double amount = amountt / coinPro.coins[0].price;
    final double balance = await WallletWithApi()
            .getWalletBalance(walletPro.wallets[0].coinsWallet[0].address) *
        coinPro.coins[0].price;
    if (balance > amount) {
      await WallletWithApi().transferCoin(
          walletPro.wallets[0].coinsWallet[0].address,
          // walletPro.walletsAddress,
          walletPro.wallets[0].coinsWallet[0].transferKey,
          //walletPro.transferKey,
          _walletaddress.text,
          amount.toString());
    } else {
      CustomToast.errorToast(message: 'You havenot enough Balance ');
    }
  }

  @override
  Widget build(BuildContext context) {
    WalletProvider walletPro = Provider.of<WalletProvider>(context);
    CoinProvider coinPro = Provider.of<CoinProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text(
                'Enter BTC Address :',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                margin: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(40)),
                child: TextFormField(
                  controller: _walletaddress,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'BTC Address',
                      labelText: 'BTC Address',
                      prefixIcon: Icon(Icons.wallet)),
                ),
              ),
              // SizedBox(
              //   height: 60,
              //   width: double.infinity,
              //   child: TextFormField(
              //     decoration: InputDecoration(
              //       contentPadding: const EdgeInsets.all(8.0),
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(5.0),
              //       ),
              //       hintText: "0",
              //     ),
              //     controller: _walletaddress,
              //   ),
              // ),
              const SizedBox(height: 16),
              const Text(
                'Amount :',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                margin: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(40)),
                child: TextFormField(
                  controller: _amount,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Amount',
                      labelText: 'Amount',
                      prefixIcon: Icon(Icons.monetization_on_outlined)),
                ),
              ),
              Row(
                children: [
                  const Text(
                    'Available Balance : ',
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
              // SizedBox(
              //   height: 60,
              //   width: 130,
              //   child: TextFormField(
              //     decoration: InputDecoration(
              //       contentPadding: const EdgeInsets.all(8.0),
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(5.0),
              //       ),
              //       hintText: "0",
              //     ),
              //     controller: _amount,
              //   ),
              // ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        btcSend();
                      },
                      child: const Text('Send')))
            ],
          ),
        ),
      ),
    );
  }
}
