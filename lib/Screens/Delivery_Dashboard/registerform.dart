import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShopSmartly Delivery Registration',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DeliveryRegistrationForm(),
    );
  }
}

class DeliveryRegistrationForm extends StatefulWidget {
  @override
  _DeliveryRegistrationFormState createState() =>
      _DeliveryRegistrationFormState();
}

class _DeliveryRegistrationFormState extends State<DeliveryRegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final databaseReference = FirebaseDatabase.instance.reference();

  String? _name;
  String? _email;
  String _selectedVehicle = 'Motorbike';
  String? _address;
  String? _state;
  String? _city;
  String? _postalCode;
  String? _country;

  bool isValidCity(String value) {
    return value.isNotEmpty;
  }

  // Create a map that associates countries with their minimum postal code length
  final Map<String, int> countryPostalCodeLength = {
    'USA': 5, // US ZIP codes typically have 5 digits
    'Canada': 6, // Canadian postal codes typically have 6 characters (e.g., "A1B 2C3")
    'UK': 5, // UK postal codes can vary but often have 5 to 7 alphanumeric characters (e.g., "SW1A 1AA")
    'Lesotho': 3, // Lesotho postal codes have 3 digits
    'Australia': 4, // Australian postal codes typically have 4 digits
    'Brazil': 8, // Brazilian postal codes (CEP) have 8 digits
    'China': 6, // Chinese postal codes typically have 6 digits
    'France': 5, // French postal codes (CEDEX) typically have 5 digits
    'Germany': 5, // German postal codes (PLZ) have 5 digits
    'India': 6, // Indian postal codes (PIN) typically have 6 digits
    'Italy': 5, // Italian postal codes (CAP) typically have 5 digits
    'Japan': 7, // Japanese postal codes have 7 digits
    'Mexico': 5, // Mexican postal codes typically have 5 digits
    'Netherlands': 6, // Dutch postal codes (postcode) have 6 digits
    'New Zealand': 4, // New Zealand postal codes (postcode) typically have 4 digits
    'Nigeria': 6, // Nigerian postal codes typically have 6 digits
    'Russia': 6, // Russian postal codes (Почтовый индекс) have 6 digits
    'South Africa': 4, // South African postal codes (ZIP) typically have 4 digits
    'Spain': 5, // Spanish postal codes (Código Postal) have 5 digits
    'Sweden': 5, // Swedish postal codes (Postnummer) typically have 5 digits
    'Switzerland': 4, // Swiss postal codes (PLZ) typically have 4 digits
    'United Arab Emirates': 5, // UAE postal codes can vary but often have 5 digits
    'Vietnam': 6, // Vietnamese postal codes typically have 6 digits
  };


  bool isValidPostalCode(String value, String country) {
    if (countryPostalCodeLength.containsKey(country)) {
      final minPostalCodeLength = countryPostalCodeLength[country]!;
      return value.isNotEmpty && value.length >= minPostalCodeLength;
    }
    return true; // If country is not found in the map, postal code is considered valid
  }

  bool isValidCountry(String value) {
    final validCountries = [
      'USA',
      'Canada',
      'UK',
      'Lesotho',
      'Australia',
      'Brazil',
      'China',
      'France',
      'Germany',
      'India',
      'Italy',
      'Japan',
      'Mexico',
      'Netherlands',
      'New Zealand',
      'Nigeria',
      'Russia',
      'South Africa',
      'Spain',
      'Sweden',
      'Switzerland',
      'United Arab Emirates',
      'Vietnam',
      'Other',
    ];
    return value.isNotEmpty && validCountries.contains(value);
  }

  bool isValidEmailDomain(String value) {
    final emailRegex =
    RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return emailRegex.hasMatch(value);
  }

  Future<bool> doesDeliveryPersonExist(String email) async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
        .collection('deliveries')
        .where('email', isEqualTo: email)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  List<String> countries = [
    'USA',
    'Canada',
    'UK',
    'Lesotho',
    'Australia',
    'Brazil',
    'China',
    'France',
    'Germany',
    'India',
    'Italy',
    'Japan',
    'Mexico',
    'Netherlands',
    'New Zealand',
    'Nigeria',
    'Russia',
    'South Africa',
    'Spain',
    'Sweden',
    'Switzerland',
    'United Arab Emirates',
    'Vietnam',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delivery Registration'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _name = value;
                  },
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!isValidEmailDomain(value)) {
                      return 'Invalid email domain';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _email = value;
                  },
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    return null;
                  },
                  onSaved: (value) {
                    _address = value;
                  },
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'State',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your state';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _state = value;
                  },
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'City',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty || !isValidCity(value)) {
                      return 'Please enter a valid city';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _city = value;
                  },
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Postal Code',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty || !isValidPostalCode(value, _country ?? '')) {
                      return 'Please enter a valid postal code';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _postalCode = value;
                  },
                ),
                SizedBox(height: 8.0),
                DropdownButtonFormField(
                  value: _country,
                  items: countries
                      .map((country) => DropdownMenuItem(
                    value: country,
                    child: Text(country),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _country = value.toString();
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Country',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty || !isValidCountry(value)) {
                      return 'Please enter a valid country';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8.0),
                DropdownButtonFormField(
                  value: _selectedVehicle,
                  items: ['Motorbike', 'Plane', 'Car']
                      .map((vehicle) => DropdownMenuItem(
                    value: vehicle,
                    child: Text(vehicle),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedVehicle = value.toString();
                    });
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();

                      final emailExists = await doesDeliveryPersonExist(_email!);
                      if (emailExists) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('A delivery person with this email already exists.'),
                          ),
                        );
                      } else {
                        try {
                          // Save data to Firestore
                          await FirebaseFirestore.instance.collection('deliveries').add({
                            'name': _name,
                            'email': _email,
                            'address': _address,
                            'state': _state,
                            'city': _city,
                            'postalCode': _postalCode,
                            'country': _country,
                            'vehicle': _selectedVehicle,
                          });

                          // Reset the form after successful submission
                          _formKey.currentState?.reset();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Delivery registration successful!'),
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error occurred while saving data to Firestore.'),
                            ),
                          );
                        }
                      }
                    }
                  },
                  child: Text('Register'),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}