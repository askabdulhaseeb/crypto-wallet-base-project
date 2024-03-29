import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/app_provider.dart';
import '../../providers/exchange_provider.dart';
import '../main_pages/exchange_coin_screen.dart';
import '../main_pages/history_page.dart';
import '../main_pages/home_page.dart';
import '../main_pages/profile_page.dart';
import '../main_pages/coin_balace_page.dart';
import 'main_bottom_navigation_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const String routeName = '/MainScreen';

  static const List<Widget> _pages = <Widget>[
    HomePage(),
    CoinScreen(),
    ExchangeCoinScreen(),
    HistoryPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    int currentIndex = Provider.of<AppProvider>(context).currentTap;
    Provider.of<ExchangeCoinProvider>(context).init();
    return Scaffold(
      body: _pages[currentIndex],
      bottomNavigationBar: const MainBottomNavigationBar(),
    );
  }
}
