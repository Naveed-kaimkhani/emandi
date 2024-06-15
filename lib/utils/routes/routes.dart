import 'package:e_mandi/main.dart';
import 'package:e_mandi/presentation/auth/login_screen.dart';
import 'package:e_mandi/presentation/billing/billing_screen.dart';
import 'package:e_mandi/presentation/billing/create_bill.dart';
import 'package:e_mandi/presentation/billing/create_bill_from_initial_list.dart';
import 'package:e_mandi/presentation/category/category_screen.dart';
import 'package:e_mandi/presentation/connections/connection_list.dart';
import 'package:e_mandi/presentation/initial/initial_list.dart';
import 'package:e_mandi/presentation/initial/initial_screen.dart';
import 'package:e_mandi/presentation/ledges/edit_ledges.dart';
import 'package:e_mandi/presentation/ledges/ledges_screen.dart';
import 'package:e_mandi/presentation/ledges/view_ledges.dart';
import 'package:e_mandi/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.login:
        return _buildRoute(const LoginScreen(), settings);

      case RoutesName.initialScreen:
        return _buildRoute(InitialScreen(itemRepository: getIt(),), settings);

      case RoutesName.billingScreen:
        return _buildRoute(const BillingScreen(), settings);

      case RoutesName.categoryScreen:
        return _buildRoute(const CategoryScreen(), settings);

      case RoutesName.initialList:
        return _buildRoute(const InitialList(), settings);

      case RoutesName.createBill:
        return _buildRoute(CreateBillFromScratch(billingRepository: getIt(),), settings);

      case RoutesName.createBillFromInitialList:
        return _buildRoute( CreateBillFromInitialList(), settings);

      case RoutesName.viewLedges:
        return _buildRoute(const ViewLedges(), settings);
      case RoutesName.editLedges:
        return _buildRoute(const EditLedges(), settings);

      case RoutesName.ledgesScreen:
        return _buildRoute(const LedgesScreen(), settings);
        
      case RoutesName.connectionScreen:
        return _buildRoute(const ConnectionScreen(), settings);

      default:
        return _buildRoute(
          const Scaffold(
            body: Center(
              child: Text("NO Route Found"),
            ),
          ),
          settings,
        );
    }
  }

  static MaterialPageRoute _buildRoute(Widget widget, RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => widget, settings: settings);
  }
}
