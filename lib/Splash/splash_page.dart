import 'package:flutter/material.dart';


class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const SplashPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/facebook.png'),
        key: const Key('splash_bloc_image'),
        widthFactor: 150,
      ),


    );
  }
}