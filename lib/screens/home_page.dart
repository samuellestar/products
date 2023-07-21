// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:forms/components/linear_gradient.dart';
import 'package:forms/models/location_model.dart';
import 'package:forms/screens/map_screen.dart';
import 'package:forms/screens/new_client_page.dart';
import 'package:forms/screens/product_list.dart';
import 'package:forms/screens/splash_screen.dart';
import 'package:forms/utils/locations_list.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:label_marker/label_marker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchedLocation = '';
  LocationModel? foundLocation;
  GoogleMapController? mapController;
  Set<Marker> markers = {};

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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MapScreen(),
                ),
              );
              // openMap();
              // locationLatController.clear();
              // locationLongController.clear();
              // locationSearchController.clear();
              // foundLocation = null;
              // showLocationListDialog(context);
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
            // Expanded(
            //   child: GoogleMap(
            //     onMapCreated: (GoogleMapController controller) {
            //       mapController = controller;
            //     },
            //     markers: markers,
            //     initialCameraPosition: CameraPosition(
            //       target: LatLng(0.0, 0.0),
            //       zoom: 1.0,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void showLocationListDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return buildAlertDialogWithList(context);
      },
    );
  }

  AlertDialog buildAlertDialogWithList(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      title: Text('Locations'),
      content: Container(
        height: 300,
        width: 300,
        child: ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: GestureDetector(
                  onTap: () {
                    print(locations[index].lat.toString());
                    print(locations[index].long.toString());
                    print(locations[index].name.toString());
                    openMap(
                        // locations[index].lat.toString(),
                        // locations[index].long.toString(),
                        // locations[index].name.toString(),
                        );
                  },
                  child: Text(
                    locations[index].name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                subtitle: GestureDetector(
                  onTap: () {
                    print(locations[index].lat.toString());
                    print(locations[index].long.toString());
                    print(locations[index].name.toString());
                    openMap(
                        // locations[index].lat.toString(),
                        // locations[index].long.toString(),
                        // locations[index].name.toString(),
                        );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Latitude: ${locations[index].lat}'),
                      Text('Longitude: ${locations[index].long}'),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog
          },
          child: Text('Close'),
        ),
      ],
    );
  }

//label_marker: ^1.0.1

  Future<void> openMap() async {
    final Uri googleMapsUrl =
        Uri.parse('https://www.google.com/maps/search/?api=1&query=');

    addMarkers();
    print('Markers: ${markers}');

    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl);
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }

  void addMarkers() {
    print('locations length ${locations.length}');
    for (int i = 0; i < locations.length; i++) {
      print('Location [${i}]: ${locations[i].toString()}');
      var location = locations[i];
      print(location.lat);
      markers.add(
        Marker(
          markerId: MarkerId('marker_$i'),
          position:
              LatLng(double.parse(location.lat), double.parse(location.long)),
          infoWindow: InfoWindow(
            title: location.name,
            snippet: location.name,
          ),
        ),
      );
    }
  }

  // void openMap() async {}
  //   print(locations);
  //   if (locations.isEmpty) {
  //     return;
  //   } else {
  //     // String locationsQuery = locations
  //     //     .map(
  //     //       (location) => location.lat,
  //     //     )
  //     //     .join('|');

  //     // The map URL with custom markers
  //     final Uri mapUrl = Uri.parse(
  //         "https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(_generateLocationsQuery())}");

  //     // final Uri mapUrl = Uri.parse(
  //     //     "https://www.google.com/maps/search/?api=1&query=${locations[0].lat},${locations[0].long}");

  //     try {
  //       await launchUrl(mapUrl);
  //     } catch (e) {
  //       print('Map url: ${mapUrl}');
  //       // Handle any exceptions that might occur during launching the URL
  //       print("Error launching map URL: $e");
  //     }
  //   }
  // }

  // String _generateLocationsQuery() {
  //   String query = "";

  //   for (var location in locations) {
  //     query += "${location.lat},${location.long},";
  //   }

  //   return query;
  // }

  // // Future<void> openMap(String latitude, String longitude, String name) async {
  // //   double lat = double.parse(latitude);
  // //   double long = double.parse(longitude);
  // //   final availableMap = await MapLauncher.installedMaps;

  // //   availableMap.first.showMarker(coords: Coords(lat, long), title: name);
  // // }
}
