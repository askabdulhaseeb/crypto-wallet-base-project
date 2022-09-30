import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../apis/auth_api.dart';
import '../../apis/signup_api.dart';
import '../../functions/time_date_functions.dart';
import '../../models/app_user.dart';
import '../../utilities/app_images.dart';
import '../../utilities/custom_validators.dart';
import '../../widget/auth/auth_icon_button.dart';
import '../../widget/auth/on_continue_with_text_widget.dart';
import '../../widget/custom_widgets/custom_elevated_button.dart';
import '../../widget/custom_widgets/custom_textformfield.dart';
import '../../widget/custom_widgets/hideable_textformfield.dart';
import '../../widget/custom_widgets/show_loading.dart';
import '../wallet_screens/wallet_setup_screen/wallet_setup_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);
  static const String routeName = '/SignupScreen';
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final String uuid = const Uuid().v4();
  SignUp() async {
    var user = await AuthApi()
        .signupUser(email: _email.text, password: _password.text);
    if (user != null) {
      final AppUser user = AppUser(
          uid: AuthApi.uid!,
          name: _name.text,
          email: _email.text.toLowerCase().trim(),
          imageURL: ' ');
      bool temp = await SignupApi().add(user);
      if (temp) {
        Navigator.of(context).pushNamed(
          WalletSetupScreen.routeName,
        );
      }
    }
  }

  bool isLoading = false;
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
                  'What’s your \nemail address!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                CustomTextFormField(
                  controller: _name,
                  lable: 'Name',
                  readOnly: isLoading,
                  validator: (String? value) =>
                      CustomValidator.lessThen3(value),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                ),
                CustomTextFormField(
                  controller: _email,
                  lable: 'Email Address',
                  hint: 'example@example.com',
                  readOnly: isLoading,
                  validator: (String? value) => CustomValidator.email(value),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                ),
                HideableTextFormField(
                  controller: _password,
                  lable: 'Your Password',
                  readOnly: isLoading,
                  validator: (String? value) => CustomValidator.password(value),
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 10),
                isLoading
                    ? const ShowLoading()
                    : CustomElevatedButton(
                        title: 'Signup',
                        // prefixIcon: const Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: 10),
                        //   child: Icon(Icons.mail, color: Colors.white),
                        // ),
                        onTap: () {
                          SignUp();
                        },
                      ),
                const SizedBox(height: 10),
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          const OrContinueWithTextWidget(),
          Row(
            children: <Widget>[
              AuthIconButton(
                imagePath: AppImages.google,
                onTap: () {},
              ),
              AuthIconButton(
                icon: Icons.apple,
                onTap: () {},
              ),
            ],
          ),
          Center(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.grey),
                children: <TextSpan>[
                  const TextSpan(
                    text: 'Already have an account? ',
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextSpan(
                    text: ' Sign In',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Navigator.of(context).pop(),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
