import 'package:flutter/material.dart';

import '../../../../../../data/models/car.dart';
import '../../../../../../data/services/firebase_services.dart';

class SelectCar extends StatelessWidget {
  final Car car1;
  const SelectCar({Key? key, required this.car1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 490,
        child: FutureBuilder(
          future: getAllCars(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              List<Car>? cars = snapshot.data;
              return ListView.builder(
                itemCount: cars?.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5.0,
                    shadowColor: Colors.terciaryColor,
                    key: Key(cars![index].id),
                    child: GestureDetector(
                      onTap: () async {
                        await Navigator.pushNamed(context, '/compare_car',
                            arguments: {
                              "car2": cars[index],
                              "car": car1
                            });
                      },
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(cars[index].image),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                cars[index].brand,
                                style: const TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              width: double.infinity,
                              height: 45,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      cars[index].model,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black),
                                    ),
                                  ),
                                  GestureDetector(
                                    child: Icon(
                                      Icons.favorite,
                                      color: cars[index].favorite == true
                                          ? Colors.red
                                          : Colors.grey,
                                    ),
                                    onTap: () {
                                      favoriteCar(cars[index].id, currentUser?.email);
                                    },
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
        ));
  }
}
