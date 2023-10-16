import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

import 'location_service.dart';


class MapSample extends StatefulWidget {
  final LatLng? initialLocation;
  final Function(LatLng)? onLocationSelected;

  MapSample({this.initialLocation, this.onLocationSelected});
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  TextEditingController _searchController = TextEditingController();
  Set<Marker> _markers = {};
  LatLng? _selectedLocation;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final Marker _Kgoogleplexmarker = Marker(markerId:
  MarkerId('_Kgoogleplex'),
    infoWindow: InfoWindow(title: 'Google Plex'),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(37.42796133580664, -122.085749655962),
  );
  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  static final Marker _Klakemarker = Marker(markerId: MarkerId('_Klakemarker'),
    infoWindow: InfoWindow(title: 'lake'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    position: LatLng(37.43296265331129, -122.08832357078792),
  );
  static final Polyline _KPolyline = Polyline(
    polylineId: PolylineId('_KPolyline'),
    points: [
      LatLng(37.42796133580664, -122.085749655962),
      LatLng(37.43296265331129, -122.08832357078792),
    ],
    width: 5,
  );
  static final Polygon _kpolygon = Polygon(polygonId: PolygonId('_kpolygon'),
    points: [
      LatLng(37.43296265331129, -122.08832357078792),
      LatLng(37.42796133580664, -122.085749655962),
      LatLng(37.418, -122.092),
      LatLng(37.435, -122.092),
    ],
    strokeWidth: 5,
    fillColor: Colors.transparent,
  );

  @override
  void initState() {
    super.initState();
    // Set the initial location when provided
    if (widget.initialLocation != null) {
      _selectedLocation = widget.initialLocation;
      _markers.add(
        Marker(
          markerId: MarkerId('selected_location'),
          position: widget.initialLocation!,
          infoWindow: InfoWindow(title: 'Selected Location'),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: Text(
          'Add new address',
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _searchController,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(hintText: 'Search by City'),
                  onChanged: (value) {
                    print(value);
                  },
                ),
              ),
              IconButton(
                onPressed: () async {
                  await _moveToLocation(_searchController.text);
                },
                icon: Icon(Icons.search),
              ),
            ],
          ),
          Container(
            height: 700,
            child: GoogleMap(
              mapType: MapType.normal,
              markers: _markers, // Set of markers
              initialCameraPosition: _selectedLocation != null
                  ? CameraPosition(target: _selectedLocation!, zoom: 15)
                  : _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onTap: (LatLng location) {
                // Handle map tap event
                setState(() {
                  _markers.clear(); // Clear existing markers
                  _markers.add(
                    Marker(
                      markerId: MarkerId('selected_location'),
                      position: location,
                      infoWindow: InfoWindow(title: 'Selected Location'),
                    ),
                  );
                  _selectedLocation = location; // Update selected location
                  widget.onLocationSelected?.call(location); // Notify the parent widget
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _moveToLocation(String locationName) async {
    try {
      final locations = await locationFromAddress(locationName);
      if (locations.isNotEmpty) {
        final firstLocation = locations.first;
        final targetLocation =
        LatLng(firstLocation.latitude, firstLocation.longitude);

        final GoogleMapController controller = await _controller.future;
        controller.animateCamera(CameraUpdate.newLatLng(targetLocation));
      } else {
        print('Location not found: $locationName');
      }
    } catch (e) {
      print('Error geocoding location: $e');
    }
  }
}
