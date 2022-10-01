import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
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
    getPrice();
    // Timer.periodic(Duration(seconds: 15), (timer) {
    //   getPrice();
    // });
  }

  getPrice() async {
    CoinProvider coinPro = Provider.of<CoinProvider>(context, listen: false);
    try {
      coinPro.coins.clear();
      String temp;
      String url = 'https://api.coingecko.com/api/v3/coins';
      var response = await http.get(Uri.parse(url));
      var json = jsonDecode(response.body);
      for (int i = 0; i < json.length; i++) {
        CoinData coinData = CoinData(
          name: json[i]['name'] ?? '',
          daypercentage:
              json[i]['market_data']['price_change_percentage_24h'] ?? 0,
          imageurl: json[i]['image']['small'] ?? '',
          marketcaprank: json[i]['market_data']['market_cap_rank'] ?? 0,
          price: json[i]['market_data']['current_price']['usd'] ?? 0,
          symbol: json[i]['symbol'] ?? '',
          weekpercentage:
              json[i]['market_data']['price_change_percentage_7d'] ?? 0,
        );
        coinPro.getAllCoins(coinData);
      }
      print('data loaded');

      //temp = json.toString();

      //var value = json['market_data']['current_price']['usd'].toString();
    } catch (e) {
      //print(e.toString());
    }
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
