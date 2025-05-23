import 'package:flutter/material.dart';
import 'package:un_ride/appColors.dart';
import 'package:un_ride/screens/Widgets/widgets.dart';

class ClientsHome extends StatefulWidget {
  final VoidCallback onMenuPressed;

  const ClientsHome({super.key, required this.onMenuPressed});

  @override
  State<ClientsHome> createState() => _ClientsHomeState();
}

class _ClientsHomeState extends State<ClientsHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Un Ride", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 93, 1, 1),
      ),
      body: Stack(
        children: [
          PublicationCard(
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
              onPressed: widget.onMenuPressed,
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}
