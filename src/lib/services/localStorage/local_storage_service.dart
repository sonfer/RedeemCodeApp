abstract class LocalStoreageService {
  Future<bool> setString(String key, String value);
  Future<String> getString(String key);
}
