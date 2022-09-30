import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/wallets.dart';
import '../widget/custom_widgets/custom_toast.dart';

class WalletsApi {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;
  static const String _collection = 'wallets';
  Future<bool> add(Wallets wallets) async {
    try {
      await _instance
          .collection(_collection)
          .doc(wallets.walletId)
          .set(wallets.toMap());
      CustomToast.successToast(message: 'Successfully Added');
      return true;
    } catch (e) {
      CustomToast.errorToast(message: e.toString());
      return false;
    }
  }
}
