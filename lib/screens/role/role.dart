import 'package:flutter/material.dart';

class RolePage extends StatelessWidget {
  const RolePage({super.key});

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const RolePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Role'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Role',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}