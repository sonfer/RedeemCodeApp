import '../../models/base_response.dart';
import '../../models/login_request.dart';

abstract class UserService {
  Future<BaseResponse> login(LoginRequest request);
}
