
import 'package:flutter/material.dart';
// import 'screens/log-in/login.dart';
import './Routes/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'logIn',
      routes: routes,
    );
  }
}
