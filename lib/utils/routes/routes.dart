import 'package:e_mandi/presentation/auth/login_screen.dart';
import 'package:e_mandi/presentation/billing/billing_screen.dart';
import 'package:e_mandi/presentation/initial/initial_screen.dart';
import 'package:e_mandi/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.login:
        return _buildRoute(const LoginScreen(), settings);

      case RoutesName.initial_screen:
        return _buildRoute(const InitialScreen(), settings);
        
      case RoutesName.billing_screen:
        return _buildRoute(const BillingScreen(), settings);
      default:
        return _buildRoute(
            const Scaffold(
              body: Center(
                child: Text("NO Route Found"),
              ),
            ),
            settings);
    }
  }

  static _buildRoute(Widget widget, RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => widget, settings: settings);
  }
}
