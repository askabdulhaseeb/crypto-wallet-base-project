import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../apis/login_api.dart';
import '../../utilities/app_images.dart';
import '../../utilities/custom_validators.dart';
import '../../widget/auth/auth_icon_button.dart';
import '../../widget/auth/on_continue_with_text_widget.dart';
import '../../widget/copyright.dart';
import '../../widget/custom_widgets/custom_elevated_button.dart';
import '../../widget/custom_widgets/custom_textformfield.dart';
import '../../widget/custom_widgets/hideable_textformfield.dart';
import '../../widget/custom_widgets/show_loading.dart';
import '../wallet_screens/wallet_setup_screen/wallet_setup_screen.dart';
import 'signup_screen.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);
  static const String routeName = '/SigninScreen';
  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool isLoading = false;
  signin() async {
    bool temp =
        await SignInApi().signin(email: _email.text, password: _password.text);
    if (temp) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushNamed(
        WalletSetupScreen.routeName,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: globalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: SizedBox(
                    height: 100,
                    child: Image.asset(AppImages.logo4x),
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Let’s sign you Up!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                CustomTextFormField(
                  controller: _email,
                  lable: 'Your Email',
                  hint: 'example@example.com',
                  readOnly: isLoading,
                  validator: (String? value) => CustomValidator.email(value),
                  keyboardType: TextInputType.emailAddress,
                ),
                HideableTextFormField(
                  controller: _password,
                  lable: 'Your Password',
                  readOnly: isLoading,
                  validator: (String? value) => CustomValidator.password(value),
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 16),
                isLoading
                    ? const ShowLoading()
                    : CustomElevatedButton(
                        title: 'Login',
                        onTap: () {
                          signin();
                        },
                      ),
                const _Footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          const OrContinueWithTextWidget(),
          // Row(
          //   children: <Widget>[
          //     AuthIconButton(
          //       imagePath: AppImages.google,
          //       onTap: () {},
          //     ),
          //     AuthIconButton(
          //       icon: Icons.apple,
          //       onTap: () {},
          //     ),
          //   ],
          // ),
          const SizedBox(height: 30),
          Center(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.grey),
                children: <TextSpan>[
                  const TextSpan(
                    text: 'Don’t have an account? ',
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextSpan(
                    text: ' Sign Up',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Navigator.of(context)
                          .pushNamed(SignupScreen.routeName),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Copyrights(),
        ],
      ),
    );
  }
}
