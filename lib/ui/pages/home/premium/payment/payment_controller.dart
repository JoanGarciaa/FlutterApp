import 'package:flutter_app/data/provider/user_repository.dart';
import 'package:flutter_app/data/services/firebase_services.dart';

class PaymentController{
  final repository = UserRepository();

  userPremium(){
    String? uid = currentUser?.email;
    repository.userPremium(uid, true);
  }
}