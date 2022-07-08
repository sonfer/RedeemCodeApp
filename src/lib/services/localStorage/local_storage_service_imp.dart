import 'package:shared_preferences/shared_preferences.dart';
import 'local_storage_service.dart';

class LocalStorageServiceImp extends LocalStoreageService {
  @override
  Future<String> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return Future<String>.value(prefs.getString(key) ?? '');
  }

  @override
  Future<bool> setString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }
}
