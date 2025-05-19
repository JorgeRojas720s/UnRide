import 'package:flutter/material.dart';
import 'package:un_ride/appColors.dart';
import 'package:un_ride/screens/Widgets/buttons/AnimatedIconButton.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  double iconsButtonsSize =
      25; //!Porque solo se ve el cambio cuando compilo de 0?

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
                onPressed: () => {print("Homeeeeeeee")},
              ),
              AnimatedIconButton(
                size: iconsButtonsSize,
                icon: Icons.push_pin_rounded,
                onPressed: () => {print("Noseeeeeeeeeeeeeeeeeeeeee")},
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: RawMaterialButton(
                      onPressed: () => print('Middle button pressed'),
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
                onPressed: () => {print("Adioooooooooooos")},
              ),
              AnimatedIconButton(
                size: iconsButtonsSize,
                icon: Icons.person,
                onPressed: () => {print("Holaaaaaaaaaaaaaaaaaaaaaaaa")},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
