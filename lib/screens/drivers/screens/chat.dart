import 'package:flutter/material.dart';
import 'package:un_ride/screens/clients/screens/chat.dart';

//!Para el futuro quitar esto de aca, solo habrá un widget de chat, asi como el de otros
class DriverChat extends StatefulWidget {
  const DriverChat({super.key});

  @override
  State<DriverChat> createState() => _DriverChatState();
}

class _DriverChatState extends State<DriverChat> {
  @override
  Widget build(BuildContext context) {
    return ChatScreen();
  }
}
