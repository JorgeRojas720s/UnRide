import 'package:flutter/material.dart';

class ClientsHome extends StatefulWidget {
  final Function? onMenuPressed;

  const ClientsHome({super.key, this.onMenuPressed});

  @override
  State<ClientsHome> createState() => _ClientsHomeState();
}

class _ClientsHomeState extends State<ClientsHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Clients Home',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed:
                () =>
                    widget.onMenuPressed != null
                        ? widget.onMenuPressed!()
                        : Navigator.pushNamed(context, '/drawer'),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Clients Home Content',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // You can add navigation or specific client-related actions here
              },
              child: const Text('Client Actions'),
            ),
          ],
        ),
      ),
    );
  }
}
