import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

enum PaymentMethod { payOnDelivery, payPal, stripe }
enum ShippingMethod { standard, express }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class FirebaseService {
  final DatabaseReference _database = FirebaseDatabase.instance.reference();

  Future<void> savePaymentData(Map<String, dynamic> paymentData) async {
    try {
      final DatabaseReference paymentRef = _database.child('YOUR_PATH_TO_PAYMENTS').push();
      await paymentRef.set(paymentData);
    } catch (error) {
      print('Error saving payment data: $error');
    }
  }
}

class payment extends StatefulWidget {
  payment({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<payment> {
  PaymentMethod? selectedPaymentMethod;
  ShippingMethod? selectedShippingMethod;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  String? selectedCountry;

  final FirebaseService firebaseService = FirebaseService();

  List<String> countries = [
    'Country 1',
    'Country 2',
    'Country 3',
    // Add more countries as needed
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Payment Form'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Payment Method',
                  style: TextStyle(fontSize: 18),
                ),
                Column(
                  children: <Widget>[
                    RadioListTile<PaymentMethod>(
                      title: Text('Pay on Delivery'),
                      value: PaymentMethod.payOnDelivery,
                      groupValue: selectedPaymentMethod,
                      onChanged: (PaymentMethod? value) {
                        setState(() {
                          selectedPaymentMethod = value;
                        });
                      },
                    ),
                    RadioListTile<PaymentMethod>(
                      title: Text('PayPal'),
                      value: PaymentMethod.payPal,
                      groupValue: selectedPaymentMethod,
                      onChanged: (PaymentMethod? value) {
                        setState(() {
                          selectedPaymentMethod = value;
                        });
                      },
                    ),
                    RadioListTile<PaymentMethod>(
                      title: Text('Stripe'),
                      value: PaymentMethod.stripe,
                      groupValue: selectedPaymentMethod,
                      onChanged: (PaymentMethod? value) {
                        setState(() {
                          selectedPaymentMethod = value;
                        });
                      },
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    TextFormField(
                      controller: firstNameController,
                      decoration: InputDecoration(labelText: 'First Name'),
                    ),
                    TextFormField(
                      controller: lastNameController,
                      decoration: InputDecoration(labelText: 'Last Name'),
                    ),
                    TextFormField(
                      controller: addressController,
                      decoration: InputDecoration(labelText: 'Address'),
                    ),
                    TextFormField(
                      controller: cityController,
                      decoration: InputDecoration(labelText: 'City'),
                    ),
                    DropdownButtonFormField<String>(
                      value: selectedCountry,
                      onChanged: (String? value) {
                        setState(() {
                          selectedCountry = value;
                        });
                      },
                      items: countries.map((String country) {
                        return DropdownMenuItem<String>(
                          value: country,
                          child: Text(country),
                        );
                      }).toList(),
                      decoration: InputDecoration(labelText: 'Country'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Shopping Cart',
                  style: TextStyle(fontSize: 18),
                ),
                // Add your shopping cart items here
                // You can use ListView or other widgets to display cart items

                SizedBox(height: 20),
                Text(
                  'Shipping Method',
                  style: TextStyle(fontSize: 18),
                ),
                Column(
                  children: <Widget>[
                    RadioListTile<ShippingMethod>(
                      title: Text('Standard (\$4.00)'),
                      value: ShippingMethod.standard,
                      groupValue: selectedShippingMethod,
                      onChanged: (ShippingMethod? value) {
                        setState(() {
                          selectedShippingMethod = value;
                        });
                      },
                    ),
                    RadioListTile<ShippingMethod>(
                      title: Text('Express (\$8.99)'),
                      value: ShippingMethod.express,
                      groupValue: selectedShippingMethod,
                      onChanged: (ShippingMethod? value) {
                        setState(() {
                          selectedShippingMethod = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Call the function to save payment data when the button is pressed
                    savePaymentDataToFirebase();
                  },
                  child: Text('Submit Payment'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> savePaymentDataToFirebase() async {
    final paymentData = {
      'paymentMethod': selectedPaymentMethod.toString(),
      'firstName': firstNameController.text,
      'lastName': lastNameController.text,
      'address': addressController.text,
      'city': cityController.text,
      'country': selectedCountry,
      'shippingMethod': selectedShippingMethod.toString(),
    };

    await firebaseService.savePaymentData(paymentData);

    // Optionally, you can show a success message or navigate to another screen.
    // Example: Navigator.of(context).pushReplacementNamed('/success');
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payment App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: payment(),
    );
  }
}

