import 'package:flutter/material.dart';
import 'package:un_ride/screens/Widgets/loaders/splash_page.dart';
import 'package:un_ride/screens/role/role.dart';
import 'package:un_ride/screens/clients/clients_home.dart';
//import 'package:un_ride/screens/sign-up/sign-up.dart';
import 'package:un_ride/screens/auth/auth.dart';
import 'package:un_ride/screens/drawer/custom-drawer.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/splash': (_) => SplashPage(),
  '/role': (_) => RolePage(),
  '/clients_home':
      (_) => Builder(
        builder:
            (context) => ClientsHome(
              onMenuPressed: () => Navigator.pushNamed(context, '/drawer'),
            ),
      ),
  //'/signUp': (_) => SignUpForm(),
  '/auth': (_) => AuthScreen(),
  '/drawer': (_) => CustomDrawer(),
};
