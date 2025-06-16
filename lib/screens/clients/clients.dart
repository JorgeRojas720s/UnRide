import 'package:flutter/material.dart';
import 'package:un_ride/screens/Widgets/animations/no_posts.dart';
import 'package:un_ride/screens/Widgets/widgets.dart';
import 'package:un_ride/screens/clients/screens/chat.dart';
import 'package:un_ride/screens/clients/screens/profile.dart';
import 'package:un_ride/screens/clients/screens/home.dart';

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
        return const ClientsHome();
      case 1:
        return ChatScreen();
      case 2:
        return NoPosts();
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
