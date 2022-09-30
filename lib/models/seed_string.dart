import 'package:cloud_firestore/cloud_firestore.dart';

class SeedString {
  SeedString({
    required this.seedphrase,
    required this.userid,
    required this.seedid,
  });
  final String seedphrase;
  final String userid;
  final String seedid;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': userid,
      'seed_id': seedid,
      'seed_string': seedphrase,
    };
  }

  factory SeedString.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    return SeedString(
      userid: doc.data()?['user_id'] ?? 'null',
      seedid: doc.data()?['seed_id'] ?? 'null',
      seedphrase: doc.data()?['seed_string'] ?? 'null',
    );
  }
}
