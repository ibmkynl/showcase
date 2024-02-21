import 'package:shared_preferences/shared_preferences.dart';

class SharedManager {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  ///Default value is ""
  static String getString(String id) => _prefs.getString(id) ?? '';

  static Future<void> setString({required String data, required String id}) async => await _prefs.setString(id, data);

  static bool? getBool(String id) => _prefs.getBool(id);

  static Future<void> setBool({required bool data, required String id}) async => await _prefs.setBool(id, data);

  ///Default value is 0
  static int getInt(String id) => _prefs.getInt(id) ?? 0;

  static Future<void> setInt({required int data, required String id}) async => await _prefs.setInt(id, data);
}
