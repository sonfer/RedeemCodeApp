import 'package:flutter/material.dart';

import '../screens/welcome_screen.dart';

class Routes {
  static const welcomeRoute = "/";
  static const authRoute = "/auth";
  static const homeRoute = "/home";
  static const storeRoute = "/store";
}

class Routers {
  static Route<dynamic> onGenerateRoute(RouteSettings? settings) {
    switch (settings?.name) {
      case Routes.welcomeRoute:
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
        break;
      case Routes.authRoute:
        //return MaterialPageRoute(builder: (_) => LoginScreen());
        break;
      case Routes.homeRoute:
        //return MaterialPageRoute(builder: (_) => HomeScreen());
        break;
      case Routes.storeRoute:
        //return MaterialPageRoute(builder: (_) => StoreScreen());
        break;
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text("${settings?.name} için route tanımlanmamış."),
                  ),
                ));
    }
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              body: Center(
                child: Text("${settings?.name} için route tanımlanmamış."),
              ),
            ));
  }
}
