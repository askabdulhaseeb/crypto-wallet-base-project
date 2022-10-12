import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/swapable_coin.dart';
import '../../models/wallets/balance.dart';
import '../../providers/balance_provider.dart';
import '../../providers/exchange_provider.dart';
import '../../utilities/app_images.dart';
import '../../wallet/wallet.dart';
import '../../widget/coin/coin_textformfield.dart';
import '../../widget/custom_widgets/custom_elevated_button.dart';
import '../../widget/custom_widgets/custom_toast.dart';
import '../../widget/custom_widgets/show_loading.dart';

class ExchangeCoinScreen extends StatefulWidget {
  const ExchangeCoinScreen({Key? key}) : super(key: key);

  @override
  State<ExchangeCoinScreen> createState() => _ExchangeCoinScreenState();
}

class _ExchangeCoinScreenState extends State<ExchangeCoinScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool isLoading = false;
  transferCoin() async {
    Balanceprovider balPro =
        Provider.of<Balanceprovider>(context, listen: false);
    if (kDebugMode) {
      print(balPro.fromBalance);
      print(balPro.from.wallet);
      print(balPro.from.transferkey);
      print(balPro.to.address);
    }
    if (balPro.from.usdtPrice >= balPro.fromBalance) {
      if (balPro.fromBalance == 0) {
        CustomToast.errorToast(message: 'invalid Amount');
      } else {
        await WallletWithApi().transferCoin(
            balPro.from.wallet,
            balPro.from.transferkey,
            balPro.to.address,
            balPro.fromBalance.toString());
      }
    } else {
      CustomToast.errorToast(message: 'invalid Amount');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exchange')),
      body: Consumer<Balanceprovider>(
          builder: (BuildContext context, Balanceprovider balancePro, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              fromSwap(context, balancePro),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                      'Avaliable ${balancePro.from.name} :  \$ ${balancePro.from.usdtPrice}'),
                  Text('${balancePro.from.name} : 0'),
                ],
              ),
              const _DividerWidger(),
              const SizedBox(height: 10),
              toSwap(context, balancePro),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () async {
                    transferCoin();
                  },
                  child: const Text('Transfer'))
            ],
          ),
        );
      }),
    );

  }

  Widget toSwap(BuildContext context, Balanceprovider balancePro) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.5),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(balancePro.fromBalance.toString()),
          ),
          DropdownButton(
              value: balancePro.to,
              style: const TextStyle(color: Colors.white),
              underline: const SizedBox(),
              hint: const Text(
                'Select coin',
                style: TextStyle(color: Colors.black),
              ),
              items: balancePro.toWallets
                  .map((WalletBalnce coin) => DropdownMenuItem<WalletBalnce>(
                        value: coin,
                        child: Text(
                          coin.name.toUpperCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ))
                  .toList(),
              onChanged: (WalletBalnce? value) {
                balancePro.toValueChange(value!);
              })
        ],
      ),
    );
  }

  Widget fromSwap(BuildContext context, Balanceprovider balancePro) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.5),
        ),
      ),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            decoration: InputDecoration(
              hintText: balancePro.fromBalance.toString(),
              prefix: Text('\$'),
              border: InputBorder.none,
            ),
            //controller: balancePro.fromController,
            onChanged: (String value) {
              if (value.isEmpty) {
                balancePro.fromBalanceValidator(0);
              } else {
                double tempvalue = double.parse(value);
                balancePro.fromBalanceValidator(tempvalue);
              }
            },
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          )),
          DropdownButton(
              value: balancePro.from,
              style: const TextStyle(color: Colors.white),
              underline: const SizedBox(),
              hint: const Text(
                'Select coin',
                style: TextStyle(color: Colors.black),
              ),
              items: balancePro.wallet
                  .map((WalletBalnce coin) => DropdownMenuItem<WalletBalnce>(
                        value: coin,
                        child: Text(
                          coin.name.toUpperCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ))
                  .toList(),
              onChanged: (WalletBalnce? value) =>
                  balancePro.formValueChange(value!))
        ],
      ),
    );
  }
}

class _Charges extends StatelessWidget {
  const _Charges({
    required this.title,
    required this.subtitle,
    // ignore: unused_element
    this.titleStyle,
    // ignore: unused_element
    this.subtitleStyle,
    Key? key,
  }) : super(key: key);
  final String title;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          title,
          style: titleStyle ?? const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          subtitle,
          style: subtitleStyle ?? const TextStyle(fontWeight: FontWeight.w300),
        ),
      ],
    );
  }
}

class _DividerWidger extends StatelessWidget {
  const _DividerWidger({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: SizedBox(
        height: 40,
        child: Row(
          children: <Widget>[
            Flexible(
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey.shade300,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: RotatedBox(
                quarterTurns: 1,
                child: Image.asset(AppImages.exchangeIcon),
              ),
            ),
            Flexible(
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey.shade300,
              ),
            )
          ],
        ),
      ),
    );
  }
}
