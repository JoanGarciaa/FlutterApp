import 'package:flutter/cupertino.dart';
import 'package:flutter_app/data/provider/user_repository.dart';

import '../../../../data/models/user_data.dart';

class CompareCarController extends ChangeNotifier {
  final repositoryUser = UserRepository();
  late UserData _user;
  UserData get user => _user;

  void afterFistLayout() {
    getPermisionPremium();
  }

  void getPermisionPremium() async {
    _user = await repositoryUser.getUser();
    notifyListeners();
  }
}
