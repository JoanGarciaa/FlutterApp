
import '../../../data/services/firebase_services.dart';

class HomeController{
  final repository = FirebaseRepository();

  Future getCarsHome(){
    return repository.getAllCarsWithFavorite();
  }

}