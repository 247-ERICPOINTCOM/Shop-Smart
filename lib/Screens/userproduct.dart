import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  AddProductScreen({Key? key}) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  var nameController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();
  var statusController = TextEditingController();
  var dateController = TextEditingController();

  final firestore = FirebaseFirestore.instance;
  File? _image;

  Future<void> _pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
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
                    keyboardType: TextInputType.number,
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
                    maxLength: 20,
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
                    controller: statusController,
                    decoration: InputDecoration(
                      labelText: 'status',
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
                    keyboardType: TextInputType.number,
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
                          statusController.text.isNotEmpty &&
                          dateController.text.isNotEmpty) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return FutureBuilder<void>(
                              future: _uploadData(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  // Show a loading indicator while uploading
                                  return AlertDialog(
                                    title: Text("Uploading..."),
                                    content: CircularProgressIndicator(),
                                  );
                                } else if (snapshot.hasError) {
                                  // Show an error message if there's an error
                                  return AlertDialog(
                                    title: Text("Error"),
                                    content: Text(
                                        "An error occurred while uploading."),
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
                                          statusController.clear();
                                          dateController.clear();
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
                    child: Text(
                      "Submit Details",
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
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
    // Upload image file to Firebase Storage
    var imageName = DateTime.now().millisecondsSinceEpoch.toString();
    var storageRef =
    FirebaseStorage.instance.ref().child('product_images/$imageName.jpg');
    var uploadTask = storageRef.putFile(_image!);
    var downloadUrl = await (await uploadTask).ref.getDownloadURL();

    await firestore.collection("Product Details").add({
      "Name": nameController.text,
      "Description": descriptionController.text,
      "Price": priceController.text,
      "status.": statusController.text,
      "date added": dateController.text,
      // Add image reference to document
      "Image": downloadUrl.toString()
    });
  }
}