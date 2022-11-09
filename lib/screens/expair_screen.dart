import 'package:flutter/material.dart';

import '../widget/copyright.dart';

class ExpairScreen extends StatelessWidget {
  const ExpairScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ExpairScreen'),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const <Widget>[
              Text('Your Demo is expaired'),
              SizedBox(height: 20),
              Copyrights(),
            ],
          ),
        ));
  }
}
