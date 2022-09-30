import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Utilities/app_images.dart';
import '../../../apis/auth_api.dart';
import '../../../apis/login_api.dart';
import '../../../providers/seed_phrase_provider.dart';
import '../../../providers/seed_provider.dart';
import '../../../widget/custom_widgets/custom_elevated_button.dart';
import '../create_wallet_screen/create_wallet_screen.dart';
import '../import_seed_screen/import_seed_screen.dart';

class WalletSetupScreen extends StatefulWidget {
  const WalletSetupScreen({Key? key}) : super(key: key);
  static const String routeName = '/WalletSetupScreen';

  @override
  State<WalletSetupScreen> createState() => _WalletSetupScreenState();
}

class _WalletSetupScreenState extends State<WalletSetupScreen> {
  void initState() {
    super.initState();
    uidprint();
  }

  uidprint() {
    print('AuthId');
    print(AuthApi.uid!);
  }

  importseed() {}

  @override
  Widget build(BuildContext context) {
    return Consumer2<SeedPhraseProvider, SeedProvider>(builder:
        (BuildContext context, SeedPhraseProvider seedPro, SeedProvider sPro,
            _) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Image.asset(AppImages.wallet),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Wallet Setup',
                  style: TextStyle(fontSize: 32),
                ),
                const Spacer(),
                CustomElevatedButton(
                    applyGradient: false,
                    title: 'Import Using Seed Phrase',
                    onTap: () {
                      sPro.load();
                      print('seeds');
                      for (int i = 0; i < sPro.seedString.length; i++) {
                        print(sPro.seedString[i].seedphrase);
                      }

                      Navigator.of(context)
                          .pushNamed(ImportSeedScreen.routeName);
                    }),
                CustomElevatedButton(
                  title: 'Create a New Wallet',
                  onTap: () async {
                    seedPro.phraselist.clear();
                    await seedPro.seedPhrase1();
                    String value = await seedPro.seedphrase;
                    print(value);
                    await seedPro.init(value);
                    Navigator.of(context)
                        .pushNamed(CreateWalletScreen.routeName);
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
