import 'package:shared_preferences/shared_preferences.dart';

class LocalData {
  static late SharedPreferences? _preferences;
  static Future<void> init() async =>
      _preferences = await SharedPreferences.getInstance();

  static const String _seedPhrase = 'SeedPhraseKEY';
  static const String _themeKey = 'ThemeKey';
  static const String _date = 'DateKey';

  //
  // Setters
  //
  static Future<void> setSeedPhrase(String uid) async =>
      _preferences!.setString(_seedPhrase, uid);

  static Future<void> setThemeMode(int value) async =>
      await _preferences?.setInt(_themeKey, value);

  static Future<void> setSession() async =>
      await _preferences!.setInt(_date, DateTime.now().day);
  //
  // Getters
  //
  static String get getSeedPhrase => _preferences!.getString(_seedPhrase) ?? '';
  static int? themeMode() => _preferences?.getInt(_themeKey);
  static bool sessionOkay() =>
      (_preferences?.getInt(_date) ?? 0) == DateTime.now().day;
}
