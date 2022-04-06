import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_login/providers/splash_provider.dart';
import 'package:social_login/resources/function.dart';
import 'package:social_login/resources/locator.dart';
import 'package:social_login/screens/splash_page.dart';

abstract class Routes {
  static Map<String, Widget Function(BuildContext context)> routeList = {
    'splash': (context) => Builder(
          builder: (context) {
            Functions.calcPlatformSize(context);
            return ChangeNotifierProvider.value(
              value: di<SplashProvider>(),
              child: const SplashPage(),
            );
          },
        ),
  };
}
