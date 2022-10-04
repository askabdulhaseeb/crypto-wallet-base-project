import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
import '../../providers/wallet_provider.dart';
import '../../widget/coin_list_view.dart';
import '../../widget/custom_widgets/circular_profile_image.dart';
import '../../widget/home/total_balance_widget.dart';
import '../see_all_coin_screen/see_all_coin_screen.dart';
import '../tranfer_screens/receive_btc_screen.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/coin_model.dart';
import '../../providers/coin_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    showWalletID();
    // getPrice();
    // Timer.periodic(Duration(seconds: 15), (timer) {
    //   getPrice();
    // });
  }

  showWalletID() {
    WalletProvider walletProvider =
        Provider.of<WalletProvider>(context, listen: false);
    print(walletProvider.wallets.length);
    print(walletProvider.wallets[0].coinsWallet);
    print(walletProvider.wallets[0].coinsWallet[1].symble);
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userPro = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: CircularProfileImage(imageURL: userPro.currentUser.imageURL),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            splashRadius: 20,
            icon: Icon(
              CupertinoIcons.search,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute<ReceiveBTCScreen>(
                builder: (BuildContext context) => const ReceiveBTCScreen(),
              ));
            },
            splashRadius: 20,
            icon: Icon(
              CupertinoIcons.qrcode_viewfinder,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Hello, \n${userPro.currentUser.name}! 👋',
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            const TotalBalanceWidget(),
            const _SeeAll(),
            const Expanded(child: CoinListView()),
          ],
        ),
      ),
    );
  }
}

class _SeeAll extends StatelessWidget {
  const _SeeAll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const Text(
          'Markets',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),
        TextButton(
          onPressed: () =>
              Navigator.of(context).pushNamed(SeeAllCoinScreen.routeName),
          child: const Text('See All'),
        ),
      ],
    );
  }
}
