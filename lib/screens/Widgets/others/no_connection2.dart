import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:un_ride/bloc/connectivity/bloc/connectivity_bloc.dart';

class NoConnection extends StatelessWidget {
  final ConnectivityState connectivityState;

  const NoConnection({super.key, required this.connectivityState});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wifi_off, size: 50, color: Colors.red),
            SizedBox(height: 20),
            Text('No hay conexión a Internet', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Opcional: verificar conexión nuevamente
                context.read<ConnectivityBloc>().add(
                  ConnectivityChanged(connectivityState.isConnected),
                );
              },
              child: Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }
}
