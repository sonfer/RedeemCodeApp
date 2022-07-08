import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:redeem_code_app/shared/constants.dart';

import 'services/localStorage/local_storage_service.dart';
import 'services/service_locator.dart';
import 'shared/routes.dart';
import 'viewModels/auth/auth_view_model.dart';
import 'viewModels/base_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new MyHttpOverrides();
  Provider.debugCheckInvalidValueType = null;
  setupServiceLocator();
  MobileAds.instance.initialize();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final localStorage = serviceLocator<LocalStoreageService>();

  @override
  void initState() {
    super.initState();
    setFcmToken();
  }

  @override
  void dispose() {
    super.dispose();
  }

  setFcmToken() {
    _firebaseMessaging.getToken().then((String? token) async {
      localStorage.setString(Constants.fcmTokenKey, token!);
      print(token);
    });
  }

  @override
  Widget build(BuildContext context) {
    //final pushNotificationService = PushNotificationService(_firebaseMessaging);
    //pushNotificationService.initialise();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BaseViewModel()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.deepPurpleAccent,
        ),
        initialRoute: Routes.welcomeRoute,
        onGenerateRoute: Routers.onGenerateRoute,
        //builder: EasyLoading.init(),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
