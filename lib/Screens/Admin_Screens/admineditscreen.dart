import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  final String productId;

  EditProductScreen({required this.productId});

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  var nameController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();
  var statusController = TextEditingController();
  var storeController = TextEditingController();
  var dateController = TextEditingController();

  final firestore = FirebaseFirestore.instance;
  File? _image;
  String? selectedStatus;

  Future<void> _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        dateController.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  Future<void> _loadProductData() async {
    try {
      final docSnapshot = await firestore
          .collection("Product Details")
          .doc(widget.productId)
          .get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        setState(() {
          nameController.text = data["Name"];
          descriptionController.text = data["Description"];
          priceController.text = data["Price"].toString();
          storeController.text = data["store."];
          dateController.text = data["date added"];

          // Set an initial value for selectedStatus
          selectedStatus = data["status."] ?? 'Enabled';

          final imageUrl = data["Image"] ?? '';
          if (imageUrl.isNotEmpty) {
            // Load and display the image from the provided URL
            // You can use Image.network for this purpose
            // Example: Image.network(imageUrl)
            // Make sure imageUrl is a valid URL pointing to an image
          }
        });
      }
    } catch (error) {
      print("Error loading product data: $error");
    }
  }
  @override
  void initState() {
    super.initState();
    _loadProductData();
  }

  Future<void> _updateProductData() async {
    try {
      await firestore.collection("Product Details").doc(widget.productId).update({
        "Name": nameController.text,
        "Description": descriptionController.text,
        "Price": double.parse(priceController.text),
        "status.": statusController.text,
        "store.": storeController.text,
        "date added": dateController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Product updated successfully."),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (error) {
      print("Error updating product data: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error updating product data."),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit Product"),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    'Edit Product',
                    style: TextStyle(fontSize: 28),
                  ),
                  Text("Edit Data"),
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
                                  : Image.file(_image!), // Display the loaded image
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              final image = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);
                              if (image != null) {
                                setState(() {
                                  _image = File(image.path);
                                });
                              }
                            },
                            child: Text('Change Image'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
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
                  if (_image != null)
                    DropdownButtonFormField<String>(
                      value: selectedStatus,
                      onChanged: (newValue) {
                        setState(() {
                          selectedStatus = newValue;
                        });
                      },
                      items: <String>[
                        'Enabled',
                        'Disabled',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'Status',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber),
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: storeController,
                    maxLength: 15,
                    decoration: InputDecoration(
                      labelText: 'Store',
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
                          selectedStatus != null &&
                          storeController.text.isNotEmpty &&
                          dateController.text.isNotEmpty) {
                        await _updateProductData();
                      }
                    },
                    child: Text("Save Changes"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

