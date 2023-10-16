import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Address/googleMap.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BOAddProductScreen extends StatefulWidget {
  BOAddProductScreen({Key? key}) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<BOAddProductScreen> {
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};
  var nameController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();
  var dateController = TextEditingController();
  File? _image;
  LatLng? _selectedLocation; // Store the selected location here

  Future<void> _pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        dateController.text =
        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  // Function to navigate to the map page
  // Function to navigate to the map page
  void _navigateToMapPage(BuildContext context) async {
    final selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MapSample(
          initialLocation: _selectedLocation,
          onLocationSelected: (location) {
            setState(() {
              _selectedLocation = location;
            });
          },
        ),
      ),
    );

    // Handle the selectedLocation if needed
    if (selectedLocation != null) {
      setState(() {
        _selectedLocation = selectedLocation;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Create Product'),
          actions: [
            // Add the Google Map icon here
            IconButton(
              icon: Icon(Icons.map),
              onPressed: () {
                _navigateToMapPage(context);
              },
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    'Create Product',
                    style: TextStyle(fontSize: 28),
                  ),
                  // Add the Google Map widget here
                  Container(
                    height: 300,
                    width: double.infinity,
                    child: GoogleMap(
                      onMapCreated: (controller) {
                        setState(() {
                          _mapController = controller;
                          _markers.clear();
                          if (_selectedLocation != null) {
                            _markers.add(
                              Marker(
                                markerId: MarkerId('selected_location'),
                                position: _selectedLocation!,
                              ),
                            );
                          }
                        });
                      },
                      markers: _markers,
                      initialCameraPosition: CameraPosition(
                        target: _selectedLocation ?? LatLng(0.0, 0.0),
                        zoom: 15.0,
                      ),
                    ),
                  ),
                  // Add a button to open a location picker
                  Text("Add Data"),
                  Container(
                    height: 150,
                    width: 300,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Center(
                              child: _image == null
                                  ? Text('No image selected.')
                                  : Image.file(_image!),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: _pickImage,
                            child: Text('Select image'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  // Display the selected location
                  if (_selectedLocation != null)
                    Text(
                      'Selected Location: ${_selectedLocation!.latitude}, ${_selectedLocation!.longitude}',
                      style: TextStyle(fontSize: 18),
                    ),
                  SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    controller: nameController,
                    maxLength: 15,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: descriptionController,
                    maxLength: 15,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: priceController,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
                    ],
                    decoration: InputDecoration(
                      labelText: 'Price',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: dateController,
                    maxLength: 10,
                    onTap: () {
                      _selectDate(context);
                    },
                    decoration: InputDecoration(
                      labelText: 'Date Added',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_image != null &&
                          nameController.text.isNotEmpty &&
                          descriptionController.text.isNotEmpty &&
                          priceController.text.isNotEmpty &&
                          dateController.text.isNotEmpty &&
                          _selectedLocation != null) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return FutureBuilder<void>(
                              future: _uploadData(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  // Show a loading indicator while uploading
                                  return AlertDialog(
                                    title: Text("Uploading..."),
                                    content: CircularProgressIndicator(),
                                  );
                                } else if (snapshot.hasError) {
                                  // Show an error message if there's an error
                                  return AlertDialog(
                                    title: Text("Error"),
                                    content: Text("An error occurred while uploading."),
                                    actions: [
                                      TextButton(
                                        child: Text("OK"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                } else {
                                  // Show a success message after uploading
                                  return AlertDialog(
                                    title: Text("Success"),
                                    content: Text("Data uploaded successfully."),
                                    actions: [
                                      TextButton(
                                        child: Text("OK"),
                                        onPressed: () {
                                          nameController.clear();
                                          descriptionController.clear();
                                          priceController.clear();
                                          dateController.clear();
                                          _selectedLocation = null; // Clear the selected location
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                }
                              },
                            );
                          },
                        );
                      }
                    },
                    child: Text("Submit Details"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _uploadData() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // Handle the case where the user is not authenticated
      return;
    }

    // Upload image file to Firebase Storage
    final imageName = DateTime.now().millisecondsSinceEpoch.toString();
    final storageRef = FirebaseStorage.instance.ref().child('product_images/$imageName.jpg');
    final uploadTask = storageRef.putFile(_image!);
    final downloadUrl = await (await uploadTask).ref.getDownloadURL();

    // Add product data to Firestore under the business owner's document
    await FirebaseFirestore.instance.collection("BusinessOwners").doc(user.uid).collection("Products").add({
      "Name": nameController.text,
      "Description": descriptionController.text,
      "Price": priceController.text,
      "Date Added": dateController.text,
      "Image": downloadUrl.toString(),
      "Location": GeoPoint(_selectedLocation!.latitude, _selectedLocation!.longitude), // Save the selected location
    });

    // Clear text controllers
    nameController.clear();
    descriptionController.clear();
    priceController.clear();
    dateController.clear();
  }
}
