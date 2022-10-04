import 'package:flutter/cupertino.dart';

import '../apis/seed_phrase_api.dart';
import '../models/seed_string.dart';

class SeedProvider with ChangeNotifier {
  SeedProvider() {
    load();
  }
  List<SeedString> _seed = <SeedString>[];
  List<SeedString> get seedString => _seed;
  Future<void> _load() async {
    _seed = await SeedPhraseApi().get();
    notifyListeners();
  }

  Future<void> load() async {
    _seed = await SeedPhraseApi().get();
    notifyListeners();
  }

  //  List<Patient> patientSearch() {
  //   final List<Patient> temp = <Patient>[];
  //   for (Patient element in _patient) {
  //     if (_search == null || (_search?.isEmpty ?? true)) {
  //       temp.add(element);
  //     } else if (element.name
  //         .toLowerCase()
  //         .startsWith((_search?.toLowerCase() ?? ''))) {
  //       temp.add(element);
  //     }
  //   }
  //   return temp;
  // }
  String seedSearch(String value) {
    String temp = 'w';
    for (SeedString element in _seed) {
      if (value == element.seedphrase) {
        temp = element.seedid;
      }
    }
    return temp;
  }
}
