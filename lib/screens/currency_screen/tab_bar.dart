// import 'package:cryptowallet/screens/bitcoin_transaction/bitcoin_recieve.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class Tabbarview extends StatefulWidget {
//   final 
//   const Tabbarview({Key? key}) : super(key: key);

//   @override
//   State<Tabbarview> createState() => _TabbarviewState();
// }

// class _TabbarviewState extends State<Tabbarview> {
//   @override
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           title: const Text(
//               'Bitcoin Transaction',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//           bottom: const TabBar(tabs: <Widget>[
//             Text(
//               'Recieve',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//             Text(
//               'Send',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//           ]),
//         ),
//         body: const TabBarView(
//           children: <Widget>[
//             ReceiveBTCScreen(),
//             SendBitcoinScreen(),
//           ],
//         ),
//       ),
//     );
//   }
// }
