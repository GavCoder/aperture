import 'package:aperture/model/user_level_enum.dart';
import 'package:flutter/foundation.dart';

class UserLevelProvider extends ChangeNotifier {
  UserLevelEnum? _selectedLevel;

  UserLevelEnum? get selectedLevel => _selectedLevel;

  void setSelectedLevel(UserLevelEnum? value) {
    if (_selectedLevel == value) {
      return;
    }

    _selectedLevel = value;
    notifyListeners();
  }
}
