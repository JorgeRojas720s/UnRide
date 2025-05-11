import 'package:flutter/material.dart';
import '../screens/log-in/log-in.dart';
import 'package:un_ride/Splash/splash_page.dart';
import 'package:un_ride/screens/role/role.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/logIn': (_) => LoginNinePage(),
  '/splash': (_) => SplashPage(),
  '/role': (_) => RolePage(),
};
