import 'dart:math';

class UserData {
  Random random = new Random();

  late String email, password, sex, username;
  late int years;
  late List favorite_cars;
  late String image = randomImage[random.nextInt(3)];
  late bool premium;
  List<String> randomImage = [
    "https://cdn.autobild.es/sites/navi.axelspringer.es/public/media/image/2018/01/mazda-rx-7_4.jpg",
    "https://www.autonocion.com/wp-content/uploads/2022/05/BMW-M4-CSL-1.jpg",
    "https://www.tuningblog.eu/wp-content/uploads/2019/02/US-BMW-E36-M3-Forgestar-M14-Tuning-21-1-e1549010912769.jpg",
    "https://img.remediosdigitales.com/7857c3/porsche--911-carrera-rsr-3-8-1993-subasta-05/1366_2000.jpeg"
  ];

  UserData(
      {required this.email,
      required this.password,
      required this.sex,
      required this.username,
      required this.years,
      required this.favorite_cars,
      required this.image,
      required this.premium});

  UserData.fromMap(Map<String, dynamic> map) {
    email = map['email'];
    password = map['password'];
    sex = map['sex'];
    username = map['username'];
    years = map['years'];
    favorite_cars = map['favorite_cars'];
    image = map['image'];
    premium = map['premium'];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "email": email,
      "password": password,
      "sex": sex,
      "username": username,
      "years": years,
      "favorite_cars": favorite_cars,
      "image": image,
      "premium": premium,
    };
  }
}
