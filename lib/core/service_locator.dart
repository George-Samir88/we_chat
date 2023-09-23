import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesGetIt = GetIt.instance;

void setupSharedPreferencesSingleton() async {
  sharedPreferencesGetIt.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
}
