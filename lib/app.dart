import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:un_ride/authentication/authentication.dart';
import 'package:un_ride/repository/repository.dart';
import 'package:un_ride/theme.dart';

import 'package:un_ride/screens/log-in/log-in.dart';
import 'package:un_ride/Splash/splash_page.dart';
import 'package:un_ride/screens/role/role.dart';

class App extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;
  const App({super.key, required this.authenticationRepository})
    : assert(authenticationRepository != null);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create:
            (_) => AuthenticationBloc(
              authenticationRepository: authenticationRepository,
            ),
        child: AppView(),
      ),
    ); 
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState? get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      navigatorKey: _navigatorKey,
      // initialRoute: '/splash',
      // routes: {
      //   '/splash': (_) => const SplashPage(),
      //   '/logIn': (_) => const LoginNinePage(),
      //   '/role': (_) => const RolePage(),
      // },
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigatorKey.currentState?.pushAndRemoveUntil<void> (
                  // '/role', //!Ahora coloco estas rutas en lo de rutas, y ver si dejo ese /
                  RolePage.route(),
                  (route) => false,
                );
                break;
                case AuthenticationStatus.unauthenticated:
                _navigatorKey.currentState?.pushAndRemoveUntil<void> (
                  // '/role', //!Ahora coloco estas rutas en lo de rutas, y ver si dejo ese /
                  LoginNinePage.route(),
                  (route) => false,
                );
                break;
              // case AuthenticationStatus.unauthenticated:
              //   _navigatorKey.currentState?.pushNamedAndRemoveUntil(
              //     '/logIn',
              //     (route) => false,
              //   );
              //   break;
              // case AuthenticationStatus.unknown:
              //   _navigatorKey.currentState?.pushNamedAndRemoveUntil(
              //     '/splash',
              //     (route) => false,
              //   );
              //   break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
