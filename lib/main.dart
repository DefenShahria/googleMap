import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late final GoogleMapController _googleMapController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Google Map',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
                color: Colors.white),
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          zoom: 20,
          bearing: 30,
          tilt: 10,
          target: LatLng(23.699513216161456, 90.43034462466196),
        ),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
        trafficEnabled: true,
        onMapCreated: (GoogleMapController controller){
          print('On map created');
          _googleMapController  = controller;
        },
        onTap: (LatLng l){
          print(l);
        },
        mapType: MapType.normal,
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
        polylines:<Polyline>{
           Polyline(polylineId: const PolylineId('polyLine'),
          color: Colors.lightBlueAccent,
          width: 3,
          jointType: JointType.round,
          onTap: (){
            print('Tapped on polyline');
          },
          points: const [
            LatLng(23.785357911107518, 90.35970971660734),
            LatLng(23.777931349934494, 90.39811931424995),
            LatLng(23.687934801186636, 90.41294305142775),
          ]
          ),
        } ,
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
     floatingActionButton: FloatingActionButton(onPressed: (){

     },
     child: Icon(Icons.my_location_sharp),),
    );
  }
}
