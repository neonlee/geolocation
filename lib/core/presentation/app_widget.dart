import 'package:cloudwatch/core/routes/named_routes.dart';
import 'package:cloudwatch/core/routes/routes.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: NamedRoutes.homePage,
      routes: Routes.routes(),
    );
  }
}
