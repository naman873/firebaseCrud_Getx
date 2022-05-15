import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class NearMe extends StatefulWidget {
  const NearMe({Key? key}) : super(key: key);

  @override
  _NearMeState createState() => _NearMeState();
}

class _NearMeState extends State<NearMe> {
  final Completer<GoogleMapController> _controller = Completer();
  Position? position;

  Set<Marker> markers = <Marker>{};

  // static const CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(position.latitude, position!.longitude),
  //   zoom: 14.4746,
  // );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  setInitialLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    position = await Geolocator.getCurrentPosition();
    print("Position ${position!.latitude} ${position!.longitude}");
    // 28.6100637 77.0917582
    for (int i = 0; i < 5; i++) {
      double lat = position!.latitude + double.parse("${0.0000000 + i}");
      double long = position!.longitude + double.parse("${0.0000000 + i}");
      LatLng latlng = LatLng(lat, long);
      Marker marker = Marker(
        markerId: MarkerId("$i"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
        position: latlng,
      );
      markers.add(marker);
    }
    setState(() {
      markers;
    });
    CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(position!.latitude, position!.longitude),
      zoom: 14.4746,
    );
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
  }

  @override
  void initState() {
    setInitialLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map"),
        centerTitle: true,
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: const CameraPosition(
          target: LatLng(37.43296265331129, -122.08832357078792),
          zoom: 14.4746,
        ),
        markers: markers,
        onMapCreated:
            // _onMapCreated
            (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  // void _onMapCreated(GoogleMapController controller) {
  //   // controller = controller;
  //   final marker = Marker(
  //     markerId: MarkerId('place_name'),
  //     position: LatLng(28.6100647, 77.0917592),
  //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
  //     infoWindow: InfoWindow(
  //       title: 'title',
  //       snippet: 'address',
  //     ),
  //   );
  //
  //   setState(() {
  //     markers.add(marker);
  //   });
  // }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }
}
