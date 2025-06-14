import 'package:flutter/material.dart';
import 'package:un_ride/screens/Widgets/animations/no_posts.dart';
import 'package:un_ride/screens/Widgets/layaout/appbar/appbar.dart';
import 'package:un_ride/screens/Widgets/layaout/navbar/navbar.dart';
import 'package:un_ride/screens/drivers/screens/home.dart';
import 'package:un_ride/screens/drivers/screens/profile.dart';

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
        return NoPosts();
      case 3:
        return const DriverProfileScreen();
      default:
        return const Center(child: Text("Pantalla no encontrada"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(canSwitch: true, isDriverMode: true),
      body: _buildBody(),
      bottomNavigationBar: NavBar(
        onTabChanged: handleTabChange,
        currentIndex: selectedIndex,
      ),
    );
  }
}
