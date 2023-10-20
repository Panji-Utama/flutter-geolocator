import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class LocationData with ChangeNotifier {
  double latitude;
  double longitude;
  String address;

  updateLocationData(double lat, double lon) async {
    latitude = lat;
    longitude = lon;

    final coordinates = Coordinates(lat, lon);
    final addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    if (addresses.isNotEmpty) {
      address = addresses.first.addressLine;
    } else {
      address = "Address not found";
    }

    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LocationData(),
      child: MaterialApp(
        title: 'Location App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LocationPage(),
      ),
    );
  }
}

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final Location location = Location();

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    try {
      final currentLocation = await location.getLocation();
      Provider.of<LocationData>(context, listen: false)
          .updateLocationData(currentLocation.latitude, currentLocation.longitude);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Current Location'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Latitude: ${Provider.of<LocationData>(context).latitude}'),
            Text('Longitude: ${Provider.of<LocationData>(context).longitude}'),
            Text('Address: ${Provider.of<LocationData>(context).address}'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MapPage()),
                );
              },
              child: Text('Show on Map'),
            ),
          ],
        ),
      ),
    );
  }
}

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final latitude = Provider.of<LocationData>(context).latitude;
    final longitude = Provider.of<LocationData>(context).longitude;

    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(latitude, longitude),
          zoom: 13.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 30.0,
                height: 30.0,
                point: LatLng(latitude, longitude),
                builder: (ctx) => Container(
                  child: Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
