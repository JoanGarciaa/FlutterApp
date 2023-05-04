
class Car {
  late final String id;
  final String brand;
  final String model;
  final String image;
  final String image2;
  final int cv;
  final int max_speed;
  final String engine;
  final bool favorite;
  final String fuel;
  final int price;
  final int torque;
  final int weight;
  double progress = 0.0;
  double speed = 0.0;


  Car({required this.id,required this.brand, required this.model, required this.image,required this.image2,required this.max_speed,required this.cv,required this.fuel,required this.engine,required this.favorite,required this.price,required this.torque,required this.weight});
}