import 'package:shared_preferences/shared_preferences.dart';

class LocalData {
  static late SharedPreferences? _preferences;
  static Future<void> init() async =>
      _preferences = await SharedPreferences.getInstance();

  static const String _seedPhrase = 'SeedPhraseKEY';

  //
  // Setters
  //
  static Future<void> setSeedPhrase(String uid) async =>
      _preferences!.setString(_seedPhrase, uid);
  //
  // Getters
  //
  static String get getSeedPhrase => _preferences!.getString(_seedPhrase) ?? '';

}