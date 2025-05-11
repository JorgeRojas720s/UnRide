import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  // static Route route() {
  //   return MaterialPageRoute(
  //     builder: (_) => const SplashPage(),
  //   );
  // }

  Widget build(BuildContext context) {
    print("🐕🐕🐕🐕");

    return Scaffold(
      body: Center(
        key: const Key('splash_bloc_image'),
        child: Lottie.asset(
          "assets/animations/AnimationRick.json",
          fit: BoxFit.cover,
          width: 300,
          height: 300,
        ),
      ),
    );
  }
}
