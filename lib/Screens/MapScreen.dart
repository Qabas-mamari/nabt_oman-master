import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Data/nabt_model.dart';
import '../Data/nabt_model.dart';
import '../Data/nabt_model.dart';

class MapScreen extends StatelessWidget {
  final Plant plant;
  const MapScreen( {super.key,  required this.plant});
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        title: const Text("plant Location"),
        backgroundColor: Colors.green,
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(plant.plantData!.latitude!, plant.plantData!.longitude!),
          zoom: 5.0,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('plantMarker'),
            position: LatLng(plant.plantData!.latitude!, plant.plantData!.longitude!),
            infoWindow:  InfoWindow(title: plant.plantData!.name!),
          ),
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    ));
  }
}
