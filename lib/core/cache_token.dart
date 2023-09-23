import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_chat/core/service_locator.dart';

void saveDataIntoSharedPreferences(
    {required String key, required String token}) async {
  await sharedPreferencesGetIt.get<SharedPreferences>().setString(key, token);
}

void removeDataFromSharedPreferences({required String key}) async {
  await sharedPreferencesGetIt.get<SharedPreferences>().remove(key);
}
