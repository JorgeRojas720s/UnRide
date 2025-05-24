import 'package:flutter/material.dart';
import 'package:un_ride/screens/Widgets/loaders/splash_page.dart';
import 'package:un_ride/screens/role/role.dart';
import 'package:un_ride/screens/clients/clients_home.dart';
import 'package:un_ride/screens/auth/auth.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/splash': (_) => const SplashPage(),
  '/role': (_) => const RolePage(),
  '/clients_home': (_) => const ClientsHome(),
  '/auth': (_) => const AuthScreen(),
};
