import 'package:flutter/material.dart';
import 'package:flutter_app/ui/pages/favorites/favorites_controller.dart';

import '../../../../data/models/car.dart';

class CardCar extends StatelessWidget {
  const CardCar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = FavoritesController();
    return SizedBox(
        height: 490,
        child: FutureBuilder(
          future: _controller.getMyFavoriteCars(),
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
                        await Navigator.pushNamed(context, '/info_car',
                            arguments: {
                              "car": cars[index],
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
                                        color: Colors.red
                                    ),
                                    onTap: () {},
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
