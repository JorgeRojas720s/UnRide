import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:un_ride/bloc/connectivity/bloc/connectivity_bloc.dart';


class NoConnection1 extends StatelessWidget {
  final ConnectivityState connectivityState;

  const NoConnection1({super.key, required this.connectivityState});

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        key: const Key('no_connection_image'),
        child: Lottie.asset(
          "assets/animations/noConnection.json",
          fit: BoxFit.cover,
          width: 300,
          height: 300,
        ),
      ),
    );
  }
}
