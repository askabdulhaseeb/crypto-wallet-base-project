import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/balance_provider.dart';
import '../../utilities/utilities.dart';
import '../custom_widgets/show_loading.dart';

class TotalBalanceWidget extends StatelessWidget {
  const TotalBalanceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Balanceprovider>(
        builder: (BuildContext context, Balanceprovider balancePro, _) {
      return Container(
        height: 100,
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors: Utilities.bproGradient),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'Total balance',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Cash available',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Text('\$${balancePro.total.toStringAsFixed(2).toString()}'),
            // FutureBuilder<double>(
            //   future: fakeBalace(),
            //   builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
            //     if (snapshot.hasError) {
            //       return const Text(
            //         '-Error-',
            //         style: TextStyle(
            //           fontWeight: FontWeight.w600,
            //           fontSize: 24,
            //         ),
            //       );
            //     } else if (snapshot.hasData) {
            //       final double balance = snapshot.data!;
            //       return Text(
            //         '\$ $balance',
            //         style: const TextStyle(
            //             fontWeight: FontWeight.w600, fontSize: 24),
            //       );
            //     } else {
            //       return const ShowLoading();
            //     }
            //   },
            // ),
          ],
        ),
      );
    });
  }

  Future<double> fakeBalace() async {
    //
    // CALL THE WALLET BALANCE API
    // AND REMOVE THIS FUNCTION
    //
    // ignore: always_specify_types
    Future.delayed(const Duration(seconds: 1));
    return 3009;
  }
}
