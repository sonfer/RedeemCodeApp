import 'dart:convert';
import 'package:flutter/material.dart';

import '../enums/view_state.dart';
import '../models/user_model.dart';
import '../services/localStorage/local_storage_service.dart';
import '../services/service_locator.dart';
import '../shared/constants.dart';

enum UserStatus {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated
}

class BaseViewModel with ChangeNotifier {
  ViewState _state = ViewState.Idle;
  String _errorMessage = "";

  ViewState get state => _state;
  String get errorMessage => _errorMessage;

  UserStatus _userStatus = UserStatus.Uninitialized;
  UserStatus get userStatus => _userStatus;

  UserInfoModel? _userInfoModel;
  UserInfoModel? get userInfoModel => _userInfoModel;

  int _wheelCounter = 0;
  int get wheelCounter => _wheelCounter;

  int _solveTryCounter = 0;
  int get solveTryCounter => _solveTryCounter;

  int _matchGameTryCounter = 0;
  int get matchGameTryCounter => _matchGameTryCounter;

  var _storeageService = serviceLocator<LocalStoreageService>();

  void setMatchGameTryCounter() {
    _matchGameTryCounter++;
    notifyListeners();
  }

  void resetMatchGameTryCounter() {
    _matchGameTryCounter = 0;
    notifyListeners();
  }

  void setSolveTryCounter() {
    _solveTryCounter++;
    notifyListeners();
  }

  void resetSolveTryCounter() {
    _solveTryCounter = 0;
    notifyListeners();
  }

  void setWheelCounter() {
    _wheelCounter++;
    notifyListeners();
  }

  void resetWheelCounter() {
    _wheelCounter = 0;
    notifyListeners();
  }

  void setViewState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  void setErrorMessage(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void setUserStatus(UserStatus status) {
    _userStatus = status;
    notifyListeners();
  }

  void setUserInfoModel(UserInfoModel userInfoModel) {
    _userInfoModel = userInfoModel;
    var data = jsonEncode(userInfoModel);

    _storeageService.setString(Constants.userDataKey, data);
    notifyListeners();
  }

  Future checkUserInfo() async {
    var isToken = await checkToken();

    if (!isToken) {
      setUserStatus(UserStatus.Unauthenticated);
    } else {
      setUserStatus(UserStatus.Authenticating);
    }
  }

  Future<bool> checkToken() async {
    await Future.delayed(const Duration(seconds: 1));
    var data = await _storeageService.getString(Constants.tokenKey);
    return data.isEmpty;
  }

  Future<String> setException(String errorText, Exception e) async {
    _userStatus = UserStatus.Unauthenticated;

    notifyListeners();
    if (e != null) {
      return FirebaseConstants.getExceptionText(e);
    } else if (errorText.isNotEmpty) {
      return errorText;
    } else {
      return FirebaseConstants.ERROR_COMMON;
    }
  }

  Future<UserInfoModel> getUserData() async {
    setViewState(ViewState.Busy);
    notifyListeners();
    var data = await _storeageService.getString(Constants.userDataKey);
    var json = jsonDecode(data);
    var response = UserInfoModel.fromJson(json);
    setUserInfoModel(response);
    notifyListeners();
    return response;
  }
}
