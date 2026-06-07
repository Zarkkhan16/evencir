import 'package:evencir_app/app/app.dart';
import 'package:evencir_app/app/di/injection.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const EvencirApp());
}
