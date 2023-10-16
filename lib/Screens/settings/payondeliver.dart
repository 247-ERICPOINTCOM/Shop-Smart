import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PayOnDeliverySettingsPage extends StatefulWidget {
  @override
  _PayOnDeliverySettingsPageState createState() =>
      _PayOnDeliverySettingsPageState();
}

class _PayOnDeliverySettingsPageState extends State<PayOnDeliverySettingsPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController productController = TextEditingController();
  bool payOnDeliveryEnabled = false; // Add this variable to track pay on delivery enablement.

  void _submitOrder() async {
    if (_formKey.currentState!.validate()) {
      // Form is valid, save the order to Firebase Firestore.
      final name = nameController.text;
      final address = addressController.text;
      final productDetails = productController.text;

      // Firebase Firestore setup (replace with your Firebase configurations).
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      try {
        if (payOnDeliveryEnabled) {
          await firestore.collection('orders').add({
            'name': name,
            'address': address,
            'productDetails': productDetails,
          });
        }

        // Order saved successfully.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Order placed successfully!')),
        );

        // Clear form fields.
        nameController.clear();
        addressController.clear();
        productController.clear();
      } catch (error) {
        // Handle any Firestore errors here.
        print('Error placing order: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Error placing order. Please try again later.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Checkbox(
                    value: payOnDeliveryEnabled,
                    onChanged: (value) {
                      setState(() {
                        payOnDeliveryEnabled = value!;
                      });
                    },
                  ),
                  Text('Pay on Delivery'),
                ],
              ),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Your Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(labelText: 'Delivery Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: productController,
                decoration: InputDecoration(labelText: 'Product Details'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter product details';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitOrder,
                child: Text('Place Order (Pay on Delivery)'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
