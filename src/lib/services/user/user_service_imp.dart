import 'package:redeem_code_app/models/base_response.dart';
import 'package:redeem_code_app/models/login_request.dart';
import 'package:redeem_code_app/services/api/api_service.dart';
import 'package:redeem_code_app/services/service_locator.dart';

import 'user_service.dart';

class UserServiceImp extends UserService {
  final _api = serviceLocator<ApiService>();
  @override
  Future<BaseResponse> login(LoginRequest request) async {
    var response = await _api.post('users/login', request);
    return BaseResponse.fromJson(response);
  }
}
