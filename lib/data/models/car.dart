class Car {
  late String id, brand, model, image, image2, engine, fuel;
  late int cv, max_speed, price, torque, weight;
  late bool favorite;
  double progress = 0.0;
  double speed = 0.0;

  Car(
      {required this.id,
      required this.brand,
      required this.model,
      required this.image,
      required this.image2,
      required this.max_speed,
      required this.cv,
      required this.fuel,
      required this.engine,
      required this.favorite,
      required this.price,
      required this.torque,
      required this.weight});


  Car.fromMap(Map<String, dynamic> map) {
    id: map["id"];
    brand: map["brand"];
    model: map['model'];
    image: map['image'];
    image2: map['image2'];
    engine: map['engine'];
    fuel: map['fuel'];
    cv: map['cv'];
    max_speed: map['max_speed'];
    price: map['price'];
    torque: map['torque'];
    weight: map['weight'];
    favorite: map['favorite'];
  }


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "brand": brand,
      "model": model,
      "image": image,
      "image2": image2,
      "engine": engine,
      "fuel": fuel,
      "cv": cv,
      "max_speed": max_speed,
      "price": price,
      "torque": torque,
      "weight": weight,
      "favorite": favorite,
    };
  }
}
