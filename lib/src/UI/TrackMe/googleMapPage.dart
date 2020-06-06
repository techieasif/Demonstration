import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../src/Bloc/ThemeBloc/bloc.dart';
import '../../../src/appStyles/appTheme.dart';
import '../../../src/shared_wigets/background_gradient.dart';

class MapsScreen extends StatefulWidget {
  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  final _scfMapKey = GlobalKey<ScaffoldState>();
  bool turnOnTracking = false;
  BitmapDescriptor bitmapDescriptor;
  String _nightMap;

  final Set<Marker> _markers = Set();
  final double _zoom = 10;

  //Initial camera position will be NEW DELHI
  CameraPosition _initialPosition =
      CameraPosition(target: LatLng(28.644800, 77.216721), zoom: 10.0);
  MapType _defaultMapType = MapType.normal;
  Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    if (Theme.of(context).brightness == Brightness.dark) {
      controller.setMapStyle(_nightMap);
    }
    _controller.complete(controller);
  }

  //getting user current location
  void _getLocation() async {
    bool isLocationEnabled = await Geolocator().isLocationServiceEnabled();
    if(isLocationEnabled){
      _scfMapKey.currentState.showSnackBar(SnackBar(
        content: Text("Location Service ON"),
      ));
    }else{
      _scfMapKey.currentState.showSnackBar(SnackBar(
        content: Text("Please enable location service"),
      ));
    }

    var currentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(
        LatLng(currentLocation.latitude, currentLocation.longitude), _zoom));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
            icon: bitmapDescriptor,
            markerId: MarkerId('me'),
            position:
                LatLng(currentLocation.latitude, currentLocation.longitude),
            infoWindow:
                InfoWindow(title: 'My Location', snippet: 'Hi, from Asif')),
      );
    });
  }


  void setCustomMarker() async {
    bitmapDescriptor = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/images/webkul.bmp');
  }

  //changing map theme based on app theme.
  void mapThemeToggle(bool isDark) async {
    final GoogleMapController controller = await _controller.future;
    if (isDark) {
      setState(() {
        controller.setMapStyle(_nightMap);
      });
    } else {
      setState(() {
        controller.setMapStyle(null);
      });
    }
  }

  @override
  void initState() {
    setCustomMarker();
    rootBundle.loadString('assets/map_night_style.txt').then((string) {
      _nightMap = string;
    });

    _getLocation();
    super.initState();
  }
//un-Comment it to get custom marker on theme change.
//  @override
//  void didChangeDependencies() {
//    _getLocation();
//    super.didChangeDependencies();
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scfMapKey,
      appBar: AppBar(
        title: Text('Track Me'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.track_changes),
            onPressed: () {
              setState(() {
                _markers.clear();
                turnOnTracking = true;
                _scfMapKey.currentState.showSnackBar(SnackBar(
                  content: Text("Tracking enabled"),
                ));
              });
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
            myLocationEnabled: turnOnTracking,
            onMapCreated: _onMapCreated,
            initialCameraPosition: _initialPosition,
          ),
        ],
      ),
    );
  }




  Widget _drawer() {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    TextStyle _customTextStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
    return Drawer(
      elevation: 16.0,
      child: Stack(
        children: <Widget>[
          isDark ? Container() : backgroundGradient,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "Locations worth checkout!",
                  style: _customTextStyle,
                ),
              ),
              Divider(),
              ListTile(
                onTap: () {
                  _goToNewYork();
                  Navigator.of(context).pop();
                },
                title: Text("New York", style: _customTextStyle),
                trailing: Icon(
                  Icons.flight_takeoff,
                  color: Colors.white,
                ),
              ),
              ListTile(
                onTap: () {
                  _goToNewDelhi();
                  Navigator.of(context).pop();
                },
                title: Text("New Delhi", style: _customTextStyle),
                trailing: Icon(Icons.airplanemode_active, color: Colors.white),
              ),
              SizedBox(
                height: 30,
              ),
              FlatButton(
                onPressed: () {
                  if (!isDark) {
                    mapThemeToggle(true);
                    Navigator.pop(context);
                    BlocProvider.of<ThemeBloc>(context)
                        .add(ThemeChanged(AppTheme.GreenDark));
                  } else {
                    mapThemeToggle(false);
                    Navigator.pop(context);
                    BlocProvider.of<ThemeBloc>(context)
                        .add(ThemeChanged(AppTheme.GreenLight));
                  }
                },
                child: Icon(Icons.lightbulb_outline),
              )
            ],
          ),
        ],
      ),
    );
  }


  //Map Camera jump to New york
  Future<void> _goToNewYork() async {
    double lat = 40.7128;
    double long = -74.0060;
    GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
            markerId: MarkerId('york'),
            position: LatLng(lat, long),
            infoWindow:
                InfoWindow(title: 'New York', snippet: 'Welcome to New York')),
      );
    });
  }

//Map camera jump to new Delhi
  Future<void> _goToNewDelhi() async {
    double lat = 28.644800;
    double long = 77.216721;

    final GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          markerId: MarkerId('delhi'),
          position: LatLng(lat, long),
          infoWindow:
              InfoWindow(title: 'New Delhi', snippet: 'Welcome to New Delhi'),
        ),
      );
    });
  }
}
