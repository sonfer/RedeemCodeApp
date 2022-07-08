import 'package:flutter/services.dart';

class Constants {
  static String baseUrl = "https://10.0.2.2:5001/";
  //static String baseUrl = "https://apigify.quirew.com/";
  //static String baseUrl = "https://apigifytest.quirew.com/";
  static String networkErrorMessage =
      "Bağlantı sağlanamadı. Lütfen internet bağlantınızı kontrol ediniz.";
  static String unauthorisedMessage =
      "Oturum süreniz sona erdi, lütfen giriş yapınız";
  static String timeoutMessage = "İstek zaman aşımına uğradı";
  static String unexpectedErrorMessage = "Beklenmedik bir hata oluştu";

  static String tokenKey = "RedeemCodeToken";
  static String fcmTokenKey = "GifyFcmTokenKey";
  static String userDataKey = "GifyUserDataKey";
  static String lowChipWarningMessage =
      "Hesabınızda yeterli Chip maalesef yok! Ücretsiz Chip kazanmak ister misiniz?";

  static String giftSendTime = "GiftSendTime";

  static String admobAppId = "ca-app-pub-7858549925649771~634190108";
  static String admobBannerId = "ca-app-pub-7858549925649771/6150329398";
  static String admobGecisId = "ca-app-pub-7858549925649771/9323287648";
  static String admobGecisRewardId = "ca-app-pub-7858549925649771/1707046725";
  static String admobRewardId = "ca-app-pub-7858549925649771/5454720041";
  static String admobNativeId = "ca-app-pub-7858549925649771/92023933626";
  static String ironSourceAppKey = "ea82a561";

  static List<String> testDevice = [
    '1F824A713FBBBAC029F421EA9F966994',
    '54FEDF4022A904F5AF9C6F706FC20BB4',
    'E950EB2CED2A156CD7503D774F2F35D4'
  ];

  // static MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  //   testDevices: testDevice != null ? testDevice : null,
  //   keywords: <String>[],
  //   childDirected: true,
  //   nonPersonalizedAds: true,
  // );
}

class FirebaseConstants {
  static const String USER_COLLECTION = "users";
  static const String ERROR_COMMON = "Unexpected error occurred";
  static const String ERROR_NO_RECORD = "No record found";

  static String getExceptionText(Exception e) {
    if (e is PlatformException) {
      return getErrorFromCode(e.code);
    } else {
      return ERROR_COMMON;
    }
  }

  static String getErrorFromCode(String code) {
    switch (code) {
      case 'ERROR_WRONG_PASSWORD':
        return "Hatalı şifre.";
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        return "Eposta adresi kullanılıyor.";
      default:
        return ERROR_COMMON;
    }
  }
}
