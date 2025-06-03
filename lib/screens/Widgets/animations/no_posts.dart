import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoPosts extends StatelessWidget {
  const NoPosts({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        key: const Key('no_posts_animation'),
        child: Lottie.asset(
          "assets/animations/noPosts.json",
          fit: BoxFit.cover,
          width: 300,
          height: 300,
        ),
      ),
    );
  }
}
