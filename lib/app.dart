import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:un_ride/blocs/authentication/authentication.dart';
import 'package:un_ride/blocs/client_post/bloc/client_post_bloc.dart';
import 'package:un_ride/blocs/connectivity/bloc/connectivity_bloc.dart';
import 'package:un_ride/repository/client_post/client_post_repository.dart';
import 'package:un_ride/repository/repository.dart';
import 'package:un_ride/theme.dart';
import 'package:un_ride/Routes/routes.dart';
import 'package:un_ride/screens/Widgets/widgets.dart';
import 'package:un_ride/screens/clients/clients_home.dart';

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
          BlocProvider(create: (_) => ConnectivityBloc()),
          BlocProvider(
            create:
                (_) => AuthenticationBloc(
                  authenticationRepository: authenticationRepository,
                ),
          ),
          BlocProvider(
            create:
                (_) => ClientPostBloc(
                  publication_repository: ClientPostRepository(),
                ),
          ),
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

  //!Revisar porque cuando se vuelve a conectar a wifi se queda en el splash de ricjk

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      navigatorKey: _navigatorKey,
      initialRoute: '/auth',
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
                  case AuthenticationStatus.unauthenticated:
                    _navigatorKey.currentState?.pushNamedAndRemoveUntil(
                      '/auth',
                      (route) => false,
                    );
                    break;
                  //!Cuando se desconecta el wifi y vuelve si usa esto, igualmente quitar, es por el sign in no trae vehicle
                  case AuthenticationStatus.authenticatedWithVehicle:
                    _navigatorKey.currentState?.pushNamedAndRemoveUntil(
                      '/role',
                      (route) => false,
                    );
                  //break;
                  case AuthenticationStatus.authenticated:
                    _navigatorKey.currentState?.pushNamedAndRemoveUntil(
                      '/clients_home',
                      (route) => false,
                    );
                    break;
                  case AuthenticationStatus.unknown:
                    _navigatorKey.currentState?.pushNamedAndRemoveUntil(
                      '/splash',
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
