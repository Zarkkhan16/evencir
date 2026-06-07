import 'package:evencir_app/app/router/app_router.dart';
import 'package:evencir_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class EvencirApp extends StatelessWidget {
  const EvencirApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Evencir',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      routerConfig: AppRouter.router,
    );
  }
}
