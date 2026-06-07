import 'package:flutter/foundation.dart';
import 'package:un_ride/repository/authentication/models/user.dart';

class UserProvider extends ChangeNotifier {
  late User _user;

  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void clearUser() {
    _user = User.empty;
    notifyListeners();
  }
}
