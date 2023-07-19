// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:forms/components/linear_gradient.dart';
import 'package:forms/models/location_model.dart';
import 'package:forms/screens/map_screen.dart';
import 'package:forms/screens/new_client_page.dart';
import 'package:forms/screens/product_list.dart';
import 'package:forms/screens/splash_screen.dart';
import 'package:forms/utils/locations_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchedLocation = '';
  LocationModel? foundLocation;

  final locationSearchController = TextEditingController();
  final locationLongController = TextEditingController();
  final locationLatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   icon: const Icon(
        //     Icons.arrow_back_ios_new_rounded,
        //     color: Colors.white,
        //   ),
        // ),
        title: const Text(
          'Home',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              final SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();

              sharedPreferences.remove('email');
              // ignore: use_build_context_synchronously
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SplashScreen(),
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 15),
              child: Icon(
                Icons.logout_rounded,
                color: Colors.white,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              locationLatController.clear();
              locationLongController.clear();
              locationSearchController.clear();
              showLocationListDialog();
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 15),
              child: Icon(
                Icons.location_on,
                color: Colors.white,
              ),
            ),
          ),
        ],
        elevation: 3,
      ),
      body: GradientContainer(
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              color: Colors.indigo.shade700,
              child: const Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 2,
                childAspectRatio: 1.3,
                mainAxisSpacing: 4,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PageNewClient(),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black,
                            style: BorderStyle.none,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/one.jpg',
                              height: 75,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'New Client',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.teal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PageProductList(),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black,
                            style: BorderStyle.none,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/two.jpg',
                              height: 75,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Product List',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.teal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showLocationListDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          content: Container(
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: locationSearchController,
                  decoration: const InputDecoration(
                    labelText: 'Locations',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: locationLatController,
                        decoration: const InputDecoration(
                          labelText: 'Latitude',
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: locationLongController,
                        decoration: const InputDecoration(
                          labelText: 'Longitude',
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (locationSearchController.text.isNotEmpty) {
                          searchLocation(locationSearchController.text);
                        } else {}
                        // searchLocation(locationSearchController.text);
                      },
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.blue,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          actions: [
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {},
                child: Text(
                  'Show in map',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  void searchLocation(String locationName) {
    setState(() {
      foundLocation = locations.firstWhere(
        (location) => location.name.toLowerCase() == locationName.toLowerCase(),
      );

      locationLongController.text = foundLocation!.long.toString();
      locationLatController.text = foundLocation!.lat.toString();
    });
  }

  // void openMap() {
  //   if (foundLocation != null) {
  //     Navigator.of(context).push(
  //       MaterialPageRoute(
  //         builder: (context) => MapScreen(
  //           latitude: double.parse(foundLocation!.lat),
  //           longitude: double.parse(foundLocation!.long),
  //         ),
  //       ),
  //     );
  //   }
  // }
}
