import 'package:flutter/material.dart';
import 'package:un_ride/screens/log-in/log-in.dart';
import 'package:un_ride/screens/Widgets/loaders/splash_page.dart';
import 'package:un_ride/screens/role/role.dart';
import 'package:un_ride/screens/clients/clients_home.dart';
//import 'package:un_ride/screens/sign-up/sign-up.dart';
import 'package:un_ride/screens/auth/auth.dart';
import 'package:un_ride/screens/drawer/custom-drawer.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/logIn': (_) => LoginNinePage(),
  '/splash': (_) => SplashPage(),
  '/role': (_) => RolePage(),
  '/clients_home': (_) => ClientsHome(),
  //'/signUp': (_) => SignUpForm(),
  '/auth': (_) => AuthScreen(),
  '/drawer': (_) => CustomDrawer(),
};
