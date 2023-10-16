import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firebase Firestore

void main() => runApp(DeliveryApp());

class DeliveryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery App',
      home: DeliveryPage(),
    );
  }
}

class DeliveryPage extends StatefulWidget {
  @override
  _DeliveryPageState createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  String selectedDeliveryMethod = 'Motorbike';
  double deliveryCharge = 0.0;
  bool isPopularShop = false;

  // Create a reference to your Firebase Firestore collection
  final CollectionReference deliveryCollection =
  FirebaseFirestore.instance.collection('deliveries');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delivery Method'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Delivery Method:'),
            DropdownButton<String>(
              value: selectedDeliveryMethod,
              onChanged: (newValue) {
                setState(() {
                  selectedDeliveryMethod = newValue!;
                  calculateDeliveryCharge();
                  // Save the selected delivery method and charge to Firebase
                  saveDeliveryInfoToFirebase();
                });
              },
              items: ['Motorbike', 'Car', 'Plane', 'Pickup'].map((method) {
                return DropdownMenuItem<String>(
                  value: method,
                  child: Text(method),
                );
              }).toList(),
            ),
            Text('Delivery Charge: $deliveryCharge%'),
            CheckboxListTile(
              title: Text('Popular Shop (Free Nearby Delivery)'),
              value: isPopularShop,
              onChanged: (newValue) {
                setState(() {
                  isPopularShop = newValue!;
                  calculateDeliveryCharge();
                  // Save the selected delivery method and charge to Firebase
                  saveDeliveryInfoToFirebase();
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  void calculateDeliveryCharge() {
    switch (selectedDeliveryMethod) {
      case 'Motorbike':
        setState(() {
          deliveryCharge = 20.0;
        });
        break;
      case 'Car':
        setState(() {
          deliveryCharge = 15.0;
        });
        break;
      case 'Plane':
        setState(() {
          deliveryCharge = 10.0;
        });
        break;
      case 'Pickup':
        setState(() {
          deliveryCharge = isPopularShop ? 0.0 : 5.0; // Adjust as needed
        });
        break;
      default:
        setState(() {
          deliveryCharge = 0.0;
        });
    }
  }

  // Function to save delivery information to Firebase Firestore
  void saveDeliveryInfoToFirebase() {
    deliveryCollection.add({
      'deliveryMethod': selectedDeliveryMethod,
      'deliveryCharge': deliveryCharge,
      'isPopularShop': isPopularShop,
    });
  }
}
