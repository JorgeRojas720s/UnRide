import 'package:flutter/material.dart';
import 'package:un_ride/screens/Widgets/widgets.dart';
import 'package:un_ride/screens/clients/screens/profile.dart';
import 'package:un_ride/screens/clients/screens/clients_home.dart';

class Clients extends StatefulWidget {
  const Clients({super.key});

  @override
  State<Clients> createState() => _ClientsState();
}

class _ClientsState extends State<Clients> {
  int selectedIndex = 0;

  void handleTabChange(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget _buildBody() {
    switch (selectedIndex) {
      case 0:
        return const ClientsHome(); // pantalla para clientes
      case 1:
        return Text("La del pin");
      case 2:
        return Text("La del cora");
      case 3:
        return const ProfileScreen();
      default:
        return const Center(child: Text("Pantalla no encontrada"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        canSwitch: true,
        isDriverMode: false,
        // onRoleChange: toggleRole,
      ),
      body: _buildBody(),
      bottomNavigationBar: NavBar(
        onTabChanged: handleTabChange,
        currentIndex: selectedIndex,
      ),
    );
  }
}
