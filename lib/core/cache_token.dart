import 'package:shared_preferences/shared_preferences.dart';

void saveDataIntoSharedPreferences(
    {required String key, required String token}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, token);
}

void removeDataFromSharedPreferences({required String key}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove(key);
}
