import 'package:shared_preferences/shared_preferences.dart';

void saveTokenIntoSharedPreferences({required String token}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
}