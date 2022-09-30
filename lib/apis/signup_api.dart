import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/app_user.dart';
import '../widget/custom_widgets/custom_toast.dart';

class SignupApi {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;
  static const String _collection = 'user';
  Future<bool> add(AppUser user) async {
    try {
      await _instance.collection(_collection).doc(user.uid).set(user.toMap());
      CustomToast.successToast(message: 'Successfully Added');
      return true;
    } catch (e) {
      CustomToast.errorToast(message: e.toString());
      return false;
    }
  }
}
