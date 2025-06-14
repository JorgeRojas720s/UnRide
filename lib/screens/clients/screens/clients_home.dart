import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:un_ride/appColors.dart';
import 'package:un_ride/blocs/driver_post/bloc/driver_post_bloc.dart';
import 'package:un_ride/screens/Widgets/driver_posts/driver_posts.dart';
import 'package:un_ride/screens/Widgets/widgets.dart';

class ClientsHome extends StatefulWidget {
  const ClientsHome({super.key});

  @override
  State<ClientsHome> createState() => _ClientsHomeState();
}

class _ClientsHomeState extends State<ClientsHome> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DriverPostBloc>().add(LoadDriversPosts());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: MainAppBar(canSwitch: true, isDriverMode: false),
      body: DriverPostBody(),
    );
  }
}
