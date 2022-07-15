import 'package:cloudwatch/core/di/localization_injection.dart';
import 'package:cloudwatch/core/presentation/app_widget.dart';
import 'package:flutter/material.dart';

void main() async {
  initInjection();
  runApp(const AppWidget());
}
