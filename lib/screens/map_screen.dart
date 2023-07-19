// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MapScreen extends StatelessWidget {
//   final double latitude;
//   final double longitude;

//   const MapScreen({super.key, required this.latitude, required this.longitude});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Map'),
//       ),
      
//       body: FlutterMap(
//         options: MapOptions(
//           center: LatLng(latitude, longitude),
//           zoom: 12.0,
//         ),
//         layers: [
//           TileLayerOptions(
//             urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//             subdomains: ['a', 'b', 'c'],
//           ),
//           MarkerLayerOptions(
//             markers: [
//               Marker(
//                 width: 80.0,
//                 height: 80.0,
//                 point: LatLng(latitude, longitude),
//                 builder: (ctx) => const Icon(
//                   Icons.location_on,
//                   color: Colors.red,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
