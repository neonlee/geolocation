import 'package:cloudwatch/core/routes/named_routes.dart';
import 'package:cloudwatch/localization/presentation/ui/home_page.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();

  static Map<String, Widget Function(BuildContext)> routes() {
    return {
      NamedRoutes.homePage: (context) => const HomePage(),
    };
  }
}
