

class UserData {
  String email;
  String password;
  String sex;
  String username;
  int years;
  List favorite_cars;
  String image = "https://cdn.autobild.es/sites/navi.axelspringer.es/public/media/image/2018/01/mazda-rx-7_4.jpg";
  bool premium;


  UserData({required this.email, required this.password, required this.sex, required this.username, required this.years, required this.favorite_cars, required this.image,required this.premium});
}