import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  GoogleMapController? _mapController;
  final Location _location = Location();
  LatLng _currentLocation = const LatLng(0, 0);
  final List<LatLng> _polylineCoordinates = [];
  final Set<Polyline> _polyLines = {};
  Marker _marker = const Marker(markerId: MarkerId('current_location'));
  bool isDrawingPermission = true;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  void _getLocation() {
    _location.onLocationChanged.listen((LocationData newLocation) {
      _currentLocation = LatLng(newLocation.latitude!, newLocation.longitude!);
      if (isDrawingPermission) {
        _updatePolyline();
      }
      _updateMarker();
      setState(() {});
    });
    _startLocationUpdates();
  }

  void _startLocationUpdates() async {
    if (await _location.serviceEnabled()) {
      _location.changeSettings(interval: 10000);
      _location.enableBackgroundMode(enable: true);
    } else {
      bool serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
  }

  void _updatePolyline() {
    _polylineCoordinates.add(_currentLocation);
    _polyLines.add(Polyline(
      polylineId: const PolylineId('tracking_polyline'),
      points: _polylineCoordinates,
      color: Colors.blue,
      width: 5,
    ));
  }

  void _updateMarker() {
    _marker = Marker(
      markerId: const MarkerId('current_location'),
      position: _currentLocation,
      infoWindow: InfoWindow(
        title: 'My current location',
        snippet:
        'Lat: ${_currentLocation.latitude}, Lng: ${_currentLocation.longitude}',
      ),
      onTap: () {
        _mapController!
            .showMarkerInfoWindow(const MarkerId('current_location'));
      },
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _mapController!.animateCamera(CameraUpdate.newLatLng(_currentLocation));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Map'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition:
        CameraPosition(target: _currentLocation, zoom: 15),
        polylines: _polyLines,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        compassEnabled: true,
        markers: <Marker>{
          Marker(
            markerId: MarkerId('Custom-Marker-1'),
            position: LatLng(23.785357911107518, 90.35970971660734),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
            draggable: true,
            onDragStart: (LatLng latlng){
              print(latlng);
            },
            onDragEnd:  (LatLng latlng){
              print(latlng);
            },
          ),
          Marker(
            markerId: MarkerId('Custom-Marker-2'),
            position: const LatLng(23.777931349934494, 90.39811931424995),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
            draggable: true,
            onDragStart: (LatLng latlng){
              print(latlng);
            },
            onDragEnd:  (LatLng latlng){
              print(latlng);
            },
          ),
          Marker(
            markerId: const MarkerId('Custom-Marker-3'),
            position: const LatLng(23.687934801186636, 90.41294305142775),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
            draggable: true,
            onDragStart: (LatLng latlng){
              print(latlng);
            },
            onDragEnd:  (LatLng latlng){
              print(latlng);
            },
          ),
        },

        circles: <Circle>{
          Circle(
            circleId: CircleId('Demo'),
            center: LatLng(23.777931349934494, 90.39811931424995),
            radius: 550,
            strokeColor: Colors.lightBlueAccent,
            strokeWidth: 2,
            fillColor: Colors.blue.shade100,


          ),
          Circle(
            circleId: CircleId('Demo-1'),
            center: LatLng(23.785357911107518, 90.35970971660734),
            radius: 550,
            strokeColor: Colors.lightBlueAccent,
            strokeWidth: 2,
            fillColor: Colors.blue.shade100,


          ),
          Circle(
            circleId: CircleId('Demo-2'),
            center: LatLng(23.687934801186636, 90.41294305142775),
            radius: 550,
            strokeColor: Colors.lightBlueAccent,
            strokeWidth: 2,
            fillColor: Colors.blue.shade100,


          ),
        },
      ),
      // floatingActionButton: FloatingActionButton(onPressed: (){
      //
      // },
      //   child: Icon(Icons.my_location_sharp),),
    );


  }
}