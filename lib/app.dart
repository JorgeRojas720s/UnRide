import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:un_ride/authentication/bloc/authentication_bloc.dart';
import 'package:un_ride/repository/repository.dart';
import 'package:un_ride/theme.dart';

class App extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;
  const App({super.key, required this.authenticationRepository})
    : assert(authenticationRepository != null);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(authenticationRepository: authenticationRepository),
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
      theme: theme,
      navigatorKey: _navigatorKey,
      builder: (context,child){
        return BlocListener(listener: (context, state){

        });
      }
    );
  }
}
