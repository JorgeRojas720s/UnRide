import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:un_ride/appColors.dart';
import 'package:un_ride/cubits/cubits.dart';
import 'package:un_ride/screens/Widgets/buttons/animated_icon_button.dart';
import 'package:un_ride/screens/clients/screens/create_ride.dart';
import 'package:un_ride/screens/drivers/screens/create_ride.dart';

class NavBar extends StatefulWidget {
  final ValueChanged<int> onTabChanged;
  final int currentIndex;
  const NavBar({
    super.key,
    required this.onTabChanged,
    required this.currentIndex,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  double iconsButtonsSize = 25;
  int selectedIndex = 0;

  bool _isCreateRideOpen = false;

  void onIconPressed(int index) {
    widget.onTabChanged(index);
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
    return BlocBuilder<RoleCubit, UserRole>(
      builder:
          (context, state) => Container(
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
                      isSelected: widget.currentIndex == 0,
                      onPressed: () => onIconPressed(0),
                    ),
                    AnimatedIconButton(
                      size: iconsButtonsSize,
                      icon: Icons.chat,
                      isSelected: widget.currentIndex == 1,
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
                              if (state == UserRole.client) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder:
                                        (context) => CreateClientRideScreen(
                                          onClose:
                                              () => Navigator.of(context).pop(),
                                        ),
                                    fullscreenDialog: true,
                                  ),
                                );
                              } else if (state == UserRole.driver) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder:
                                        (context) => CreateDriverRideScreen(
                                          onClose:
                                              () => Navigator.of(context).pop(),
                                        ),
                                    fullscreenDialog: true,
                                  ),
                                );
                              }
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
                      icon: Icons.collections_bookmark_rounded,
                      isSelected: widget.currentIndex == 2,
                      onPressed: () => onIconPressed(2),
                    ),
                    AnimatedIconButton(
                      size: iconsButtonsSize,
                      icon: Icons.person,
                      isSelected: widget.currentIndex == 3,
                      onPressed: () => onIconPressed(3),
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }
}
