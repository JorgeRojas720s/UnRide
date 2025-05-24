import 'package:flutter/material.dart';
import 'package:un_ride/appColors.dart';
import 'package:un_ride/screens/Widgets/widgets.dart';
import 'package:un_ride/screens/drawer/custom-drawer.dart';

class ClientsHome extends StatefulWidget {
  const ClientsHome({super.key});

  @override
  State<ClientsHome> createState() => _ClientsHomeState();
}

class _ClientsHomeState extends State<ClientsHome> {
  bool _isDrawerOpen = false;

  void _toggleDrawer() {
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Un Ride", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 93, 1, 1),
      ),
      body: Stack(
        children: [
          // Contenido principal
          Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    const PublicationCard(
                      oigin: "Canollas",
                      destination: "Pz",
                      description: "Mamahuevaso",
                    ),
                    Positioned(
                      top: 25,
                      right: 16,
                      child: FloatingActionButton(
                        mini: true,
                        backgroundColor: Colors.black,
                        child: const Icon(Icons.menu, color: Colors.white),
                        onPressed: _toggleDrawer,
                      ),
                    ),
                  ],
                ),
              ),
              const NavBar(),
            ],
          ),

          if (_isDrawerOpen)
            CustomDrawer(
              onClose: _toggleDrawer,
              onItemSelected: (screen) {
                _toggleDrawer();
                if (screen != 'clients') {
                  // Navegar a otra pantalla
                }
              },
            ),
        ],
      ),
    );
  }
}
