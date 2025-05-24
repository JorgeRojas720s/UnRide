import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:un_ride/appColors.dart';
import 'package:un_ride/blocs/client_post/bloc/client_post_bloc.dart';
import 'package:un_ride/screens/Widgets/widgets.dart';
import 'package:un_ride/screens/drawer/custom_drawer.dart';

class ClientsHome extends StatefulWidget {
  const ClientsHome({super.key});

  @override
  State<ClientsHome> createState() => _ClientsHomeState();
}

class _ClientsHomeState extends State<ClientsHome> {
  // bool _isDrawerOpen = false;
  bool _isDriverMode = false;
  bool _canSwitchToDriver = true;

  // void _toggleDrawer() {
  //   setState(() {
  //     _isDrawerOpen = !_isDrawerOpen;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    context.read<ClientPostBloc>().add(LoadClientPosts());
  }

  void _toggleRole(bool isDriver) {
    setState(() {
      _isDriverMode = isDriver;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Un Ride",
          style: TextStyle(color: AppColors.textPrimary),
        ),
        backgroundColor: AppColors.scaffoldBackground,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: RoleSwitchButton(
              isDriverMode: _isDriverMode,
              onChanged: _toggleRole,
              canSwitchToDriver: _canSwitchToDriver,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          BlocBuilder<ClientPostBloc, ClientPostState>(
            builder: (context, state) {
              if (state.status == ClientPostStatus.loading) {
                print("👾👾👾👾👾👾👾👾👾👾");
                return const Center(child: CircularProgressIndicator());
              } else if (state.status == ClientPostStatus.success) {
                print("😏😏😏😏😏😏😏😏");
                final posts = state.posts;
                return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return PublicationCard(
                      oigin: post['origin'],
                      destination: post['destination'],
                      description: post['description'],
                    );
                  },
                );
              } else if (state.status == ClientPostStatus.error) {
                print("❌❌❌❌❌❌❌");
                return Center(child: Text("Error al cargar posts"));
              }
              return const SizedBox();
            },
          ),
        ],
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}








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