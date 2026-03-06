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
            items: UserLevelEnum.values
                .map(
                  (level) => DropdownMenuItem<UserLevelEnum>(
                    value: level,
                    child: Text(level.name),
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
