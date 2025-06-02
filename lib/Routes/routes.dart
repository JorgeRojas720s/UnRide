import 'package:flutter/material.dart';
import 'package:un_ride/screens/Widgets/loaders/splash_page.dart';
import 'package:un_ride/screens/role/role.dart';
import 'package:un_ride/screens/clients/clients.dart';
import 'package:un_ride/screens/auth/auth.dart';
import 'package:un_ride/screens/clients/screens/profile.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/splash': (_) => const SplashPage(),
  '/role': (_) => const RolePage(),
  '/clients': (_) => const Clients(),
  '/auth': (_) => const AuthScreen(),
  '/profile': (_) => const ProfileScreen(),
};
