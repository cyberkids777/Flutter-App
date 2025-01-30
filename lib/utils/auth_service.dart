import 'package:shared_preferences/shared_preferences.dart';

import '../db/notes_database.dart';

class AuthService {
  static const String isLoggedInKey = 'isLoggedIn';
  static const String userEmailKey = 'userEmail';

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isLoggedInKey) ?? false;
  }

  static Future<void> saveLoginState(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isLoggedInKey, true);
    await prefs.setString(userEmailKey, email);
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await NotesDatabase.instance.close();
    await prefs.setBool(isLoggedInKey, false);
    await prefs.remove(userEmailKey);
  }

  static Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmailKey);
  }
}