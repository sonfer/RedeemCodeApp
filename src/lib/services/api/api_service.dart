abstract class ApiService {
  Future<dynamic> get(String url, {String token = ""});
  Future<dynamic> post(String url, dynamic body, {String token = ""});
  Future<dynamic> put(String url, dynamic body, {String token = ""});
  Future<dynamic> delete(String url, {String token = ""});
}
