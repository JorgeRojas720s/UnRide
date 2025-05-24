import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:un_ride/appColors.dart';
import 'package:un_ride/blocs/authentication/authentication.dart';
import 'package:un_ride/screens/Widgets/buttons/AnimatedIconButton.dart';
import 'package:un_ride/screens/clients/create_client_ride.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  double iconsButtonsSize = 25;
  int selectedIndex = 0;
  bool _isCreateRideOpen = false;

  void onIconPressed(int index) {
    setState(() {
      selectedIndex = index;
    });

    switch (index) {
      case 0:
        print("Homeeeeeeee");
        break;
      case 1:
        print("Noseeeeeeeeeeeeeeeeeeeeee");
        break;
      case 2:
        context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested());
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil('/auth', (route) => false);
        break;
      case 3:
        print("Holaaaaaaaaaaaaaaaaaaaaaaaa");
        break;
    }
  }

  void _openCreateRide() {
    setState(() {
      _isCreateRideOpen = true;
    });
  }

  void _closeCreateRide() {
    setState(() {
      _isCreateRideOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 90,
      decoration: const BoxDecoration(color: Color.fromARGB(0, 0, 0, 0)),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Material(
                color: AppColors.scaffoldBackground,
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.scaffoldBackground,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 10,
                        color: Color.fromARGB(30, 255, 255, 255),
                        spreadRadius: 0.1,
                      ),
                    ],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AnimatedIconButton(
                size: iconsButtonsSize,
                icon: Icons.home_rounded,
                isSelected: selectedIndex == 0,
                onPressed: () => onIconPressed(0),
              ),
              AnimatedIconButton(
                size: iconsButtonsSize,
                icon: Icons.push_pin_rounded,
                isSelected: selectedIndex == 1,
                onPressed: () => onIconPressed(1),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: RawMaterialButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder:
                                (context) => CreateRideScreen(
                                  onClose: () => Navigator.of(context).pop(),
                                ),
                            fullscreenDialog: true,
                          ),
                        );
                      },
                      elevation: 2.0,
                      fillColor: AppColors.iconsNavBarColor,
                      child: const Icon(
                        Icons.add,
                        size: 30.0,
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(15.0),
                      shape: const CircleBorder(),
                    ),
                  ),
                ],
              ),
              AnimatedIconButton(
                size: iconsButtonsSize,
                icon: Icons.favorite_rounded,
                isSelected: selectedIndex == 2,
                onPressed: () => onIconPressed(2),
              ),
              AnimatedIconButton(
                size: iconsButtonsSize,
                icon: Icons.person,
                isSelected: selectedIndex == 3,
                onPressed: () => onIconPressed(3),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
