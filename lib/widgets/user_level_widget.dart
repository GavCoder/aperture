import 'package:aperture/model/user_level_enum.dart';
import 'package:aperture/providers/user_level_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserLevel extends StatelessWidget {
  const UserLevel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(left: 20),
      child: Consumer<UserLevelProvider>(
        builder: (context, userLevelProvider, _) {
          return DropdownButton<UserLevelEnum>(
            value: userLevelProvider.selectedLevel,
            hint: const Text(
              'Select User Level',
              style: TextStyle(color: Colors.white),
            ),
            // White text for the selected value displayed on the button
            selectedItemBuilder: (context) {
              return UserLevelEnum.values
                  .map(
                    (level) => DropdownMenuItem<UserLevelEnum>(
                      value: level,
                      child: Text(
                        level.name,
                        style: const TextStyle(
                            color: Colors.white), //white when selected
                      ),
                    ),
                  ).toList();
            },
            // Default (dark) text for the dropdown popup list
            items: UserLevelEnum.values
                .map(
                  (level) => DropdownMenuItem<UserLevelEnum>(
                    value: level,
                    child: Text(
                      level.name, //default dark color for readability in popup
                    ),
                  ),
                )
                .toList(),
            onChanged: userLevelProvider.setSelectedLevel,
          );
        },
      ),
    );
  }
}
