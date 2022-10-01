import 'package:firebase_auth/firebase_auth.dart';

import '../widget/custom_widgets/custom_toast.dart';

class SignInApi {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> signin({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email.toLowerCase().trim(), password: password);
      CustomToast.successToast(message: 'Successfully');
      return true;
    } catch (err) {
      CustomToast.errorToast(message: err.toString());
      return false;
    }
  }
}
