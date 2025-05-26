import 'package:flutter/material.dart';

import 'package:un_ride/appColors.dart';

import 'package:un_ride/screens/Widgets/widgets.dart';
import 'package:un_ride/screens/clients/profile.dart';
import 'package:un_ride/screens/clients/screens/clients_home.dart';

class Clients extends StatefulWidget {
  const Clients({super.key});

  @override
  State<Clients> createState() => _ClientsState();
}

class _ClientsState extends State<Clients> {
  // bool _isDrawerOpen = false;
  bool _isDriverMode = false;
  bool _canSwitchToDriver = true;
  int selectedIndex = 0;

  void handleTabChange(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  // void _toggleDrawer() {
  //   setState(() {
  //     _isDrawerOpen = !_isDrawerOpen;
  //   });
  // }

  void _toggleRole(bool isDriver) {
    setState(() {
      _isDriverMode = isDriver;
    });
  }

  Widget _buildBody() {
    switch (selectedIndex) {
      case 0:
        return const ClientsHome(); // pantalla para clientes
      case 1:
        return Text("La del pin");
      case 2:
      // !La del corazon
      case 3:
        return const ProfileScreen();
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


//!El drawable de fabian
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text(
  //         "Un Ride",
  //         style: TextStyle(color: AppColors.textPrimary),
  //       ),
  //       backgroundColor: AppColors.scaffoldBackground,
  //       actions: [
  //         Padding(
  //           padding: const EdgeInsets.only(right: 16.0),
  //           child: RoleSwitchButton(
  //             isDriverMode: _isDriverMode,
  //             onChanged: _toggleRole,
  //             canSwitchToDriver: _canSwitchToDriver,
  //           ),
  //         ),
  //       ],
  //     ),
  //     body: Stack(
  //       children: [
  //         Column(
  //           children: [
  //             Expanded(
  //               child: Stack(
  //                 children: [
  //                   const PublicationCard(
  //                     oigin: "Canollas",
  //                     destination: "Pz",
  //                     description: "Mamahuevaso",
  //                   ),

  //                   // Positioned(
  //                   //   top: 25,
  //                   //   right: 16,
  //                   //   child: FloatingActionButton(
  //                   //     mini: true,
  //                   //     backgroundColor: Colors.black,
  //                   //     child: const Icon(Icons.menu, color: Colors.white),
  //                   //     onPressed: _toggleDrawer,
  //                   //   ),
  //                   // ),
  //                 ],
  //               ),
  //             ),
  //             const NavBar(),
  //           ],
  //         ),

  //         // if (_isDrawerOpen)
  //         //   CustomDrawer(
  //         //     onClose: _toggleDrawer,
  //         //     onItemSelected: (screen) {
  //         //       _toggleDrawer();
  //         //       if (screen != 'clients') {
  //         //         // Navegar a otra pantalla
  //         //       }
  //         //     },
  //         //   ),
  //       ],
  //     ),
  //   );
  // }