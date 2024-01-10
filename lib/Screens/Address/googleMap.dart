import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shopsmartly/constants/constants.dart';

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
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            markers: _markers,
            initialCameraPosition: _selectedLocation != null
                ? CameraPosition(target: _selectedLocation!, zoom: 15)
                : _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            onTap: (LatLng location) {
              setState(() {
                _markers.clear();
                _markers.add(
                  Marker(
                    markerId: MarkerId('selected_location'),
                    position: location,
                    infoWindow: InfoWindow(title: 'Selected Location'),
                  ),
                );
                _selectedLocation = location;
                widget.onLocationSelected?.call(location);
              });
            },
          ),
          Positioned(
            bottom: 20,
            right: 100,
            left: 100,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "");
              },
              child: Text(
                "Confirm location",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 180, 214, 119),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: Size(200, 50),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _searchController,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hintText: 'Search by City',
                          fillColor: kPrimaryLightColor,
                          filled: true),
                      onChanged: (value) {
                        print(value);
                      },
                    ),
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
