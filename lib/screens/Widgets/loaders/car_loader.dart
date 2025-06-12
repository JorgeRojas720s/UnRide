import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CarLoader extends StatelessWidget {
  const CarLoader({super.key});

  Widget build(BuildContext context) {
    print("🐕🐕🐕🐕");

    return Scaffold(
      body: Transform.translate(
        offset: Offset(-70, 0),
        child: Center(
          child: Lottie.asset(
            "assets/animations/whiteCar.json",
            fit: BoxFit.cover,
            width: 250,
            height: 250,
          ),
        ),
      ),
    );
  }
}
