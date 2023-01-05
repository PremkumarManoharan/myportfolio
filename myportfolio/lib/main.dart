import '/injection_container.dart';
import 'package:flutter/material.dart';
import '/app_theme.dart';
import '/presentation/pages/home/home_page.dart';
import '/presentation/routes/routes.dart';
import '/values/values.dart';
import 'package:layout/layout.dart';

import 'configure_web.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  configureApp();
  runApp(Aerium());
}

class Aerium extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Layout(
      child: MaterialApp(
        title: StringConst.APP_TITLE,
        theme: AppTheme.lightThemeData,
        debugShowCheckedModeBanner: false,
        initialRoute: HomePage.homePageRoute,
        onGenerateRoute: RouteConfiguration.onGenerateRoute,
      ),
    );
  }
}
