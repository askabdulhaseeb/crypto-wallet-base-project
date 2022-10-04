import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/seed_string.dart';
import '../widget/custom_widgets/custom_toast.dart';
import 'auth_api.dart';

class SeedPhraseApi {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;
  static const String _collection = 'seedphrase';
  Future<bool> add(SeedString user) async {
    try {
      await _instance
          .collection(_collection)
          .doc(user.seedid)
          .set(user.toMap());
      CustomToast.successToast(message: 'Successfully Added');
      return true;
    } catch (e) {
      CustomToast.errorToast(message: e.toString());
      return false;
    }
  }

//   Future<List<Patient>> getPatient() async {
//     List<Patient> patient = <Patient>[];
//     QuerySnapshot<Map<String, dynamic>> snapshot = await _instance
//         .collection(_collection)
//         .orderBy('timestamp', descending: true)
//         .get();
//     for (DocumentSnapshot<Map<String, dynamic>> e in snapshot.docs) {
//       patient.add(Patient.fromDocument(e));
//     }
//     return patient;
//   }
// }
  Future<List<SeedString>> get() async {
    // ignore: always_specify_types
    List<SeedString> temp = [];

    QuerySnapshot<Map<String, dynamic>> snapshot = await _instance
        .collection(_collection)
        .where('user_id', isEqualTo: AuthApi.uid)
        .get();
    for (DocumentSnapshot<Map<String, dynamic>> e in snapshot.docs) {
      temp.add(SeedString.fromDocument(e));
    }
    return temp;
  }
}
