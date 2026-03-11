import 'package:aperture/model/menu_items.dart';
import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

//A PopUpMenu class extending a StatelessWidget
class PopUpMenu extends StatelessWidget {
  const PopUpMenu({super.key});

  @override
  Widget build(BuildContext context) {

    //A widget that will display a pop up menu when pressed
    return IconButton(
      onPressed: () {
        showPopover(
          context: context,
          bodyBuilder: (context) => const MenuItems(), // MenuItems widget to handle the items
          width: 200,
          height: 200,
          backgroundColor: Colors.deepPurple,
          direction: PopoverDirection.bottom,
          arrowWidth: 12
        );
      },
      icon: Image.asset('assets/images/Logo.png', width: 30, height: 30,),
    );
  }
}