import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:un_ride/appColors.dart';
import 'package:un_ride/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:un_ride/blocs/client_post/bloc/client_post_bloc.dart';
import 'package:un_ride/screens/Widgets/widgets.dart';

class DriverHome extends StatefulWidget {
  const DriverHome({super.key});

  @override
  State<DriverHome> createState() => _DriverHomeState();
}

class _DriverHomeState extends State<DriverHome> {
  bool _isDriverMode = true;
  bool _canSwitchToDriver =
      true; // You'll need to determine this based on your business logic

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ClientPostBloc>().add(LoadClientsPosts());
    });
  }

  // void _toggleRole(bool isDriver) {
  //   setState(() {
  //     _isDriverMode = isDriver;
  //   });
  //   // Add your role switching logic here

  //   if (!_isDriverMode) {
  //     //!Es mejor cargar una ruta o el widget?
  //     Navigator.of(
  //       context,
  //     ).pushNamedAndRemoveUntil('/clients', (route) => false);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: MainAppBar(canSwitch: true, isDriverMode: true),
      body: const ClientPostBody(),
    );
  }
}
