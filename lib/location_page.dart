// import 'package:flutter/material.dart';
// import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
// import 'package:latlong2/latlong.dart';

// class LocationPage extends StatefulWidget {
//   const LocationPage({Key? key}) : super(key: key);

//   @override
//   State<LocationPage> createState() => _LocationPageState();
// }

// class _LocationPageState extends State<LocationPage> {
//   LatLng? _currentPosition;
//   bool _showingMarker = false;

//   void _showMarker() {
//     setState(() {
//       _showingMarker = true;
//     });
//   }

//   void _closeMarker() {
//     setState(() {
//       _showingMarker = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_showingMarker) {
//       return Scaffold(
//         appBar: AppBar(title: const Text("Show Marker Page")),
//         body: SafeArea(
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   height: 300, // Adjust the size as needed
//                   child: OSMFlutter(
//                     currentPosition: _currentPosition ?? LatLng(0.0, 0.0),
//                     zoom: 15.0,
//                     markers: {
//                       Marker(
//                         width: 40.0,
//                         height: 40.0,
//                         point: _currentPosition ?? LatLng(0.0, 0.0),
//                         builder: (ctx) => Container(
//                           child: Icon(
//                             Icons.location_pin,
//                             color: Colors.red,
//                             size: 40.0,
//                           ),
//                         ),
//                       ),
//                     }, controller: null,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: _closeMarker,
//                   child: const Text("Close"),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     } else {
//       return Scaffold(
//         appBar: AppBar(title: const Text("Location Page")),
//         body: SafeArea(
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('LAT: ${_currentPosition?.latitude ?? ""}'),
//                 Text('LNG: ${_currentPosition?.longitude ?? ""}'),
//                 const SizedBox(height: 32),
//                 ElevatedButton(
//                   onPressed: _showMarker,
//                   child: const Text("Show Marker"),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     }
//   }
// }
