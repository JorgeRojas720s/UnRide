import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RolePage extends StatelessWidget {
  const RolePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 150,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  "Choose your role 📍",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ],
            ),
          ),
          Transform.translate(
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
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed:
                      () => Navigator.of(context).pushNamedAndRemoveUntil(
                        //!Qiza mejor deajr el pushNamed para que conserve la ruta del role
                        '/clients_home',
                        (route) => false,
                      ),
                  child: Text('Client'),
                ),
                SizedBox(height: 16),
                // ElevatedButton(
                //   onPressed: () {
                //     Navigator.of(context).pushNamedAndRemoveUntil(
                //       '/clients_home',
                //       (route) => false,
                //     );
                //   },
                //   child: Text('Driver'),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
