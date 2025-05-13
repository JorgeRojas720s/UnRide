import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:un_ride/bloc/authentication/authentication.dart';
import 'package:un_ride/bloc/connectivity/bloc/connectivity_bloc.dart';
import 'package:un_ride/repository/repository.dart';
import 'package:un_ride/screens/Widgets/animations/no_connection1.dart';
import 'package:un_ride/theme.dart';
import 'package:un_ride/Routes/routes.dart';
import 'package:un_ride/screens/Widgets/others/no_connection2.dart';

// import 'package:un_ride/screens/log-in/log-in.dart';
// import 'package:un_ride/Splash/splash_page.dart';
// import 'package:un_ride/screens/role/role.dart';

class App extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;
  const App({super.key, required this.authenticationRepository})
    : assert(authenticationRepository != null);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create:
                (_) => AuthenticationBloc(
                  authenticationRepository: authenticationRepository,
                ),
          ),
          BlocProvider(create: (_) => ConnectivityBloc()),
        ],

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      navigatorKey: _navigatorKey,
      initialRoute: '/splash',
      routes: routes,
      builder: (context, child) {
        return BlocBuilder<ConnectivityBloc, ConnectivityState>(
          builder: (context, connectivityState) {
            if (!connectivityState.isConnected) {
              return NoConnection1(connectivityState: connectivityState);
            }

            return BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                switch (state.status) {
                  case AuthenticationStatus.authenticated:
                    _navigatorKey.currentState?.pushNamedAndRemoveUntil(
                      '/role',
                      (route) => false,
                    );
                    break;
                  case AuthenticationStatus.unauthenticated:
                    _navigatorKey.currentState?.pushNamedAndRemoveUntil(
                      '/signUp',
                      (route) => false,
                    );
                    break;
                  default:
                    break;
                }
              },
              child: child,
            );
          },
        );
      },
    );
  }
}










// class AppView extends StatefulWidget {
//   const AppView({super.key});

//   @override
//   State<AppView> createState() => _AppViewState();
// }

// class _AppViewState extends State<AppView> {
//   final _navigatorKey = GlobalKey<NavigatorState>();

//   // NavigatorState? get _navigator => _navigatorKey.currentState;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: theme,
//       navigatorKey: _navigatorKey,
//       initialRoute: '/splash',
//       routes: routes,
//       builder: (context, child) {
//         return BlocListener<AuthenticationBloc, AuthenticationState>(
//           listener: (context, state) {
//             switch (state.status) {
//               case AuthenticationStatus.authenticated:
//                 _navigatorKey.currentState?.pushNamedAndRemoveUntil(
//                   '/role',
//                   (route) => false,
//                 );
//                 break;

//               case AuthenticationStatus.unauthenticated:
//                 _navigatorKey.currentState?.pushNamedAndRemoveUntil(
//                   '/signUp', //!Aqui va login y que desde login se acceda al sign Up
//                   (route) => false,
//                 );
//                 break;
//                 // case AuthenticationStatus.unknown:
//                 //_navigatorKey.currentState?.pushNamedAndRemoveUntil(
//                 // '/splash',
//                 // (route) => false,
//                 //);
//                 break;
//               default:
//                 break;
//             }
//           },
//           child: child,
//         ); 
//       },
      
//     );
//   }
// }
