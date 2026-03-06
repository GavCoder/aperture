import 'package:flutter/material.dart';
import 'package:aperture/model/user_level_enum.dart';

class UserLevel extends StatefulWidget {
  const UserLevel({super.key});

  @override
  State<UserLevel> createState() => _UserLevelState();
}

class _UserLevelState extends State<UserLevel> {
  UserLevelEnum? _selectedLevel;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(
        left: 20,
      ),
      child: DropdownButton<UserLevelEnum>(
        value: _selectedLevel,
        hint: const Text(
          'Select User Level',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        items: UserLevelEnum.values.map(
          (level) {
            return DropdownMenuItem(
              value: level,
              child: Text(level.name),
            );
          },
        ).toList(),
        onChanged: (value) {
          setState(() {
            _selectedLevel = value;
          });
        },
      ),
    );
  }
}
