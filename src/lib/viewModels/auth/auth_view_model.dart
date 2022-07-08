import 'package:redeem_code_app/services/service_locator.dart';

import '../../enums/view_state.dart';
import '../../models/login_request.dart';
import '../../models/user_model.dart';
import '../../services/api/api_service.dart';
import '../../services/localStorage/local_storage_service.dart';
import '../../services/user/user_service.dart';
import '../../shared/constants.dart';
import '../base_view_model.dart';

class AuthViewModel extends BaseViewModel {
  final _api = serviceLocator<ApiService>();
  final _userService = serviceLocator<UserService>();
  final _storeageService = serviceLocator<LocalStoreageService>();

  Future checkLogin() async {
    try {
      setViewState(ViewState.Busy);
      var fcmToken = await _storeageService.getString(Constants.fcmTokenKey);

      var loginRequest = LoginRequest(fcmToken: fcmToken);
      var loginResult = await _userService.login(loginRequest);
      if (loginResult.success!) {
        var userInfoModel = UserInfoModel.fromMap(loginResult.data);
        _storeageService.setString(
            Constants.tokenKey, userInfoModel.authToken!);
        setUserStatus(UserStatus.Authenticated);
        setUserInfoModel(userInfoModel);
        setViewState(ViewState.Completed);
        notifyListeners();
      }
    } catch (e) {
      setViewState(ViewState.Error);
      setUserStatus(UserStatus.Unauthenticated);
    }
    setViewState(ViewState.Idle);
  }
}
