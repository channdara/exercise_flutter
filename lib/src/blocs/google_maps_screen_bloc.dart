import 'dart:async';

import 'package:exercise_flutter/src/models/shop.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsScreenBloc {
  final Completer<GoogleMapController> completer = Completer();
  late GoogleMapController controller;
  final Set<Marker> markers = {};

  void initMarkers(List<Shop> shops) {
    for (final element in shops) {
      markers.add(Marker(
        markerId: MarkerId(element.latLng.latitude.toString()),
        position: element.latLng,
        infoWindow: InfoWindow(title: element.shopName),
      ));
    }
  }

  Future<void> moveCamera(LatLng latLng) async {
    if (!completer.isCompleted) return;
    controller = await completer.future;
    final update = CameraUpdate.newCameraPosition(initCamPosition(latLng));
    controller.animateCamera(update);
  }

  CameraPosition initCamPosition(LatLng latLng) {
    return CameraPosition(target: latLng, zoom: 15.0);
  }
}
