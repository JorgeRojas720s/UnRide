import 'package:flutter/material.dart';

import 'package:un_ride/screens/Widgets/layaout/navbar/navbar.dart';
import 'package:un_ride/screens/drivers/screens/driver_home.dart';

class Drivers extends StatefulWidget {
  const Drivers({super.key});

  @override
  State<Drivers> createState() => _DriversState();
}

class _DriversState extends State<Drivers> {
  int selectedIndex = 0;

  void handleTabChange(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget _buildBody() {
    switch (selectedIndex) {
      case 0:
        return DriverHome();
      case 1:
        return Text("La del pin");
      case 2:
        return Text("La del cora");
      case 3:
      // return const ProfileScreen();
      default:
        return const Center(child: Text("Pantalla no encontrada"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: NavBar(
        onTabChanged: handleTabChange,
        currentIndex: selectedIndex,
      ),
    );
  }
}
