import 'package:flutter/material.dart';
import 'package:flutter_app/ui/pages/home/search_car/search_car_controller.dart';
import 'package:flutter_app/ui/pages/home/search_car/widgets/item_car_search.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../../../data/models/car.dart';
import '../../../../data/models/user_data.dart';
import '../../../../data/services/firebase_services.dart';
import '../../../../utils/drawer/drawer_menu.dart';

class SearchCarPage extends StatefulWidget {
  const SearchCarPage({Key? key}) : super(key: key);

  @override
  State<SearchCarPage> createState() => _SearchCarPageState();
}

class _SearchCarPageState extends State<SearchCarPage> {
  bool _isClicked = false;
  UserData? user;
  int currentIndex = 2;
  List<Car>? cars = [];

  final _controller = SearchCarController();

  void _handleClick() {
    setState(() {
      _isClicked = !_isClicked;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GNav(
        gap: 8,
        tabBackgroundColor: Colors.mainColor,
        tabs: const [
          GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(icon: Icons.favorite, text: 'Favoritos'),
          GButton(
            icon: Icons.search,
            text: 'Buscar',
          ),
          GButton(
            icon: Icons.person,
            text: 'Perfil',
          ),
        ],
        selectedIndex: currentIndex,
        onTabChange: (index) {
          setState(() {
            currentIndex = index;
          });
          if (currentIndex == 0) {
            Navigator.pushReplacementNamed(context, '/');
          }
          if (currentIndex == 1) {
            Navigator.pushReplacementNamed(context, '/favorites');
          }
          if (currentIndex == 3) {
            Navigator.pushReplacementNamed(context, '/profile');
          }
        },
      ),
      drawer: const HomeDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.secondaryColor),
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
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 300,
              height: 80,
              child: Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue == '') {
                    return const Iterable<String>.empty();
                  }
                  return _controller.list.where((String item) {
                    return item.contains(textEditingValue.text);
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
                          padding: const EdgeInsets.all(8.0),
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
                    cursorColor: Colors.terciaryColor,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.terciaryColor,
                      ),
                      labelText: 'Buscar',
                      labelStyle: TextStyle(color: Colors.secondaryColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.terciaryColor)),
                    ),
                  );
                },
                onSelected: (item) {
                  setState(() {
                    _controller.setItemSelected(item);
                  });
                  cars?.clear();
                },
              ),
            ),
            SizedBox(
                height: 490,
                child: FutureBuilder(
                  future: _controller.getCarsSearch(_controller.itemSelected!),
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      cars = snapshot.data;
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
                                  await Navigator.pushNamed(
                                      context, '/info_car',
                                      arguments: {
                                        "car": cars![index],
                                      });
                                  setState(() {});
                                },
                                child: ItemCarSearch(
                                  cars: cars!,
                                  index: index,
                                )),
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
