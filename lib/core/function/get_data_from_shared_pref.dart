import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getTokenFromCacheMemory({required String key}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString(key);
  return token;
}
