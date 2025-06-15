import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:un_ride/repository/authentication/authentication_repository.dart';
import 'package:un_ride/simple_bloc_observer.dart';
import 'package:un_ride/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: ".env");
    if (Firebase.apps.isEmpty) {
      print("Inicializando Firebase por primera vez");
      await Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: dotenv.env['API_KEY']!,
          appId: dotenv.env['APP_ID']!,
          messagingSenderId: dotenv.env['MESSAGING_SENDER_ID']!,
          projectId: dotenv.env['PROJECT_ID']!,
          storageBucket: dotenv.env['STORAGE_BUCKET']!,
          authDomain: dotenv.env['AUTH_DOMAIN'],
          measurementId: dotenv.env['MEASUREMENT_ID'],
        ),
      );
    }
  } catch (e) {
    print("Error durante la inicialización: $e");
    if (e.toString().contains('duplicate-app')) {
      print("Continuando con Firebase ya inicializado...");
    } else {
      rethrow;
    }
  }

  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = SimpleBlocObserver();
  runApp(App(authenticationRepository: AuthenticationRepository()));
}
