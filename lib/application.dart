import 'package:bookstore_app/core/theme/app_theme.dart';
import 'package:bookstore_app/global_provider.dart';
import 'package:bookstore_app/routes/app_router.dart';
import 'package:flutter/material.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalProvider(
      child: MaterialApp.router(
        title: 'Bookstore App',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
      ),
    );
  }
}
