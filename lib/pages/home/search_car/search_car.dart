import 'package:flutter/material.dart';
import 'package:flutter_app/models/user_data.dart';
import 'package:flutter_app/services/firebase_services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../drawer/drawer_menu.dart';
import '../../../fonts/fonts.dart';
import '../../../models/car.dart';

class SearchCarPage extends StatefulWidget {
  const SearchCarPage({Key? key}) : super(key: key);

  @override
  State<SearchCarPage> createState() => _SearchCarPageState();
}

class _SearchCarPageState extends State<SearchCarPage> {
  bool _isClicked = false;
  UserData? user;
  static const List<String> list = <String>[
    'audi',
    'bmw',
    'ford',
    'ferrari',
    'lexus',
    'lamborguini',
    'mclaren',
    'mercedes',
    'nissan',
    'porsche',
    'volkswagen'
  ];

  void _handleClick() {
    setState(() {
      _isClicked = !_isClicked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "AutoSpecs",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 5.0,
        ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Container(
              width: 300,
              height: 80,
              child: Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue){
                  if(textEditingValue == ''){
                    return const Iterable<String>.empty();
                  }return list.where((String item){
                    return item.contains(textEditingValue.text.toLowerCase());
                  });
                },
                optionsViewBuilder: (BuildContext context,
                    AutocompleteOnSelected<String> onSelected,
                    Iterable<String> options) {
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Material(
                      elevation: 4.0,
                      child: SizedBox(
                        height: 200.0,
                        child: ListView.builder(
                          padding: EdgeInsets.all(8.0),
                          itemCount: options.length,
                          itemBuilder: (BuildContext context, int index) {
                            final String option = options.elementAt(index);
                            return GestureDetector(
                              onTap: () {
                                onSelected(option);
                              },
                              child: ListTile(
                                title: Text(option),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
                fieldViewBuilder: (BuildContext context,
                    TextEditingController textEditingController,
                    FocusNode focusNode,
                    VoidCallback onFieldSubmitted) {
                  return TextFormField(
                    controller: textEditingController,
                    focusNode: focusNode,
                    onFieldSubmitted: (String value) {
                      onFieldSubmitted();
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search,color: Colors.terciaryColor,),
                      labelText: 'Buscar',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.terciaryColor)),
                    ),
                  );
                },
                onSelected: (String item){
                  print(item);
                },
              ),
            ),
            Container(
                height: 510,
                width: 700,
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
                                // getCar(snapshot.data?[index]['uid']);
                                print("HOOL");
                                await Navigator.pushNamed(context, '/info-car',
                                    arguments: {
                                      "brand": cars[index].brand,
                                      "model": cars[index].model,
                                      "image": cars[index].image,
                                      "max_speed": cars[index].max_speed,
                                      "fuel": cars[index].fuel,
                                      "cv": cars[index].cv,
                                      "engine": cars[index].engine,
                                      "id": cars[index].id,
                                    });
                                setState(() {});
                              },
                              child: Container(
                                height: 200,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        cars[index].image),
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
                                            child: Icon(Icons.favorite, color: _isClicked? Colors.red:Colors.grey,),
                                            onTap: () {
                                              _handleClick();
                                              favoriteCar(cars[index].id,user?.email);
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
                ))
          ],
        ),
      ),
    );
  }
}
