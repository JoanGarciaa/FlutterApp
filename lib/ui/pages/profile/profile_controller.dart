import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/provider/user_repository.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../data/models/user_data.dart';

class ProfileController extends ChangeNotifier {
  final repository = UserRepository();

  Future<UserData?> getUser() async {
    return await repository.getUser();
  }
}
