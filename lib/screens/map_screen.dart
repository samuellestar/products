import 'package:flutter/material.dart';
import 'package:forms/models/location_model.dart';
import 'package:forms/utils/locations_list.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? controller;
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    // Call the function to add markers with info windows
    addMarkers();

    print('Marker: ${markers}');
  }

  void setInitialCameraPosition() {
    double totalLatitude = 0.0;
    double totalLongitude = 0.0;

    for (var location in locations) {
      totalLatitude += double.parse(location.lat);
      totalLongitude += double.parse(location.long);
    }

    double averageLatitude = totalLatitude / locations.length;
    double averageLongitude = totalLongitude / locations.length;

    controller?.moveCamera(
      CameraUpdate.newLatLng(LatLng(averageLatitude, averageLongitude)),
    );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'Map',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 3,
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: const CameraPosition(
          
          target: LatLng(9.968501451971086, 76.31528433334067),
          zoom: 10.0,
        ),
        markers: markers,
        onMapCreated: ((mapController) {
          setState(() {
            controller = mapController;
          });
        }),
      ),
    );
  }
}
