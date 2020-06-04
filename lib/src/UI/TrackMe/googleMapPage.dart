import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class MapsScreen extends StatefulWidget {
  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {

  ///TODO: listen for geolocator location stream and add marker
  final Set<Marker> _markers = Set();
  final Map<String, Marker> _marker = {};
  final double _zoom = 10;
  //Initial camera position will be NEW DELHI
  CameraPosition _initialPosition = CameraPosition(target: LatLng(28.644800, 77.216721), zoom: 10.0);
  MapType _defaultMapType = MapType.normal;
  Completer<GoogleMapController> _controller = Completer();


  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }


  void _getLocation() async {
    var currentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(LatLng(currentLocation.latitude, currentLocation.longitude), _zoom));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
            markerId: MarkerId('me'),
            position: LatLng(currentLocation.latitude, currentLocation.longitude),
            infoWindow: InfoWindow(title: 'My Location',  snippet: 'Hi, from Asif')),
      );
    });
  }

//  @override
//  void initState() {
//    _getLocation();
//    super.initState();
//  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    _getLocation();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Track Me'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.track_changes),
            onPressed: (){

            },
          )
        ],
      ),
      drawer: _drawer(),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            myLocationButtonEnabled: true,
            markers: _markers,
            mapType: _defaultMapType,
            myLocationEnabled: true,
            onMapCreated: _onMapCreated,
            initialCameraPosition: _initialPosition,
          ),


        ],
      ),
    );
  }

  Widget _drawer(){
    return Drawer(
      elevation: 16.0,
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("xyz"),
            accountEmail: Text("xyz@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text("xyz"),
            ),
            otherAccountsPictures: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Text("abc"),
              )
            ],
          ),
          ListTile(
            title: new Text("Places"),
            leading: new Icon(Icons.flight),
          ),
          Divider(),
          ListTile(
            onTap: (){
              _goToNewYork();
              Navigator.of(context).pop();
            },
            title: new Text("New York"),
            trailing: new Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            onTap: (){
              _goToNewDelhi();
              Navigator.of(context).pop();
            },
            title: new Text("New Delhi"),
            trailing: new Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            onTap: (){
              _goToLondon();
              Navigator.of(context).pop();
            },
            title: new Text("London"),
            trailing: new Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            onTap: (){
              _goToTokyo();
              Navigator.of(context).pop();
            },
            title: new Text("Tokyo"),
            trailing: new Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            onTap: (){
              _goToDubai();
              Navigator.of(context).pop();
            },
            title: new Text("Dubai"),
            trailing: new Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            onTap: (){
              _goToParis();
              Navigator.of(context).pop();
            },
            title: new Text("Paris"),
            trailing: new Icon(Icons.arrow_forward_ios),
          )
        ],
      ),
    );
  }


  Future<void> _goToNewYork() async {
    double lat = 40.7128;
    double long = -74.0060;
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
            markerId: MarkerId('newyork'),
            position: LatLng(lat, long),
            infoWindow: InfoWindow(title: 'New York', snippet: 'Welcome to New York')
        ),
      );
    });
  }

  Future<void> _goToNewDelhi() async {
    double lat = 28.644800;
    double long = 77.216721;

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
            markerId: MarkerId('newdelhi'),
            position: LatLng(lat, long),
            infoWindow: InfoWindow(title: 'New Delhi',  snippet: 'Welcome to New Delhi')),
      );
    });
  }

  Future<void> _goToLondon() async {
    double lat = 51.5074;
    double long = -0.1278;
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
            markerId: MarkerId('london'),
            position: LatLng(lat, long),
            infoWindow: InfoWindow(title: 'London',  snippet: 'Welcome to London')),
      );
    });
  }

  Future<void> _goToTokyo() async {
    double lat = 35.6795;
    double long = 139.77171;
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
            markerId: MarkerId('tokyo'),
            position: LatLng(lat, long),
            infoWindow: InfoWindow(title: 'Tokyo',  snippet: 'Welcome to Tokyo')),
      );
    });
  }

  Future<void> _goToDubai() async {
    double lat = 25.2048;
    double long =55.2708;
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
            markerId: MarkerId('dubai'),
            position: LatLng(lat, long),
            infoWindow: InfoWindow(title: 'Dubai',  snippet: 'Welcome to Dubai')),
      );
    });
  }

  Future<void> _goToParis() async {
    double lat = 48.8566;
    double long = 2.3522;
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
            markerId: MarkerId('paris'),
            position: LatLng(lat, long),
            infoWindow: InfoWindow(title: 'Paris',  snippet: 'Welcome to Paris')),
      );
    });
  }
}
