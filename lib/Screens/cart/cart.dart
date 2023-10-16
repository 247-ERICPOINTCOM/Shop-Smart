import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'package:shopsmartly/Screens/product_details/product_details.dart';

import '../settings/paypalsetting.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String businessOwnerUid;
  final GeoPoint location; // Use GeoPoint for location
  final String pickupLocation; // Add pickup location field

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.businessOwnerUid,
    required this.location,
    required this.pickupLocation, // Initialize with a pickup location
  });
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class Cart {
  final List<CartItem> items = [];

  double get totalPrice {
    return items.fold(
      0.0,
      (total, current) => total + current.product.price * current.quantity,
    );
  }

  int get itemCount {
    return items.fold(
      0,
      (count, current) => count + current.quantity,
    );
  }

  void addItem(Product product, int quantity) {
    final existingItemIndex = items.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (existingItemIndex != -1) {
      items[existingItemIndex].quantity += quantity;
    } else {
      items.add(CartItem(product: product, quantity: quantity));
    }
  }

  void removeItem(CartItem item) {
    items.remove(item);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping Cart App',
      home: ProductList(),
    );
  }
}

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final Cart cart = Cart();
  double userBudget = 5000.0; // Set the initial user budget here
  double totalSpent = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
        actions: <Widget>[
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CartScreen(cart: cart)),
                  );
                },
              ),
              cart.itemCount > 0
                  ? Positioned(
                      // Display badge if cart is not empty
                      right: 11,
                      top: 11,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 20,
                          minHeight: 20,
                        ),
                        child: Text(
                          cart.itemCount.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : SizedBox.shrink(), // Hide badge if cart is empty
            ],
          ),
          TextButton(
            onPressed: () {
              _showBudgetDialog(context);
            },
            child: Text(
              'Budget: \$${userBudget.toStringAsFixed(2)}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collectionGroup('Products').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(), // Show loading indicator
            );
          }

          final documents = snapshot.data!.docs;

          if (documents.isEmpty) {
            return Center(
              child: Text('No products available.'),
            );
          }

          final products = documents.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            final name = data['Name'] ?? 'No Name';
            final price = data['Price'];
            final businessOwnerUid = data['BusinessOwnerUid'] ?? '';
            final location = data['Location'] as GeoPoint;
            final pickupLocation =
                data['PickupLocation'] ?? ''; // Retrieve pickup location data

            double priceAsDouble;

            if (price is double) {
              priceAsDouble = price;
            } else if (price is int) {
              priceAsDouble = price.toDouble();
            } else if (price is String) {
              priceAsDouble = double.tryParse(price) ?? 0.0;
            } else {
              priceAsDouble = 0.0;
            }

            return Product(
              id: doc.id,
              name: name,
              price: priceAsDouble,
              imageUrl: data['Image'] ?? '',
              businessOwnerUid: businessOwnerUid,
              location: location,
              pickupLocation:
                  pickupLocation, // Include pickup location in the Product object
            );
          }).toList();
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProductDetails(product: product),
                  ));

                  /*// Show a dialog to display business owner ID
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Business Owner ID'),
                        content: Text('Business Owner ID: ${product.businessOwnerUid}'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Close'),
                          ),
                        ],
                      );
                    },
                  );*/
                },
                child: ListTile(
                  title: Text(product.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('\$${product.price.toStringAsFixed(2)}'),
                      Text(
                          'Latitude: ${product.location.latitude.toStringAsFixed(6)}'),
                      Text(
                          'Longitude: ${product.location.longitude.toStringAsFixed(6)}'),
                    ],
                  ),
                  leading: Image.network(product.imageUrl),
                  // Display product photo
                  trailing: Column(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.add_shopping_cart),
                        onPressed: () {
                          if (totalSpent + product.price <= userBudget) {
                            // Show quantity dialog
                            showDialog(
                              context: context,
                              builder: (context) {
                                int selectedQuantity = 1;
                                return AlertDialog(
                                  title: Text('Select Quantity'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text('Quantity: $selectedQuantity'),
                                      Slider(
                                        value: selectedQuantity.toDouble(),
                                        onChanged: (value) {
                                          selectedQuantity = value.toInt();
                                        },
                                        min: 1,
                                        max: 10,
                                        divisions: 9,
                                      ),
                                    ],
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        final totalPrice =
                                            product.price * selectedQuantity;
                                        cart.addItem(product, selectedQuantity);
                                        totalSpent += totalPrice;
                                        Navigator.of(context).pop();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Added ${selectedQuantity}x ${product.name} to cart',
                                            ),
                                            duration: Duration(seconds: 2),
                                          ),
                                        );
                                      },
                                      child: Text('Add to Cart'),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Cannot add ${product.name} to cart. Exceeds budget.',
                                ),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showBudgetDialog(BuildContext context) {
    double newBudget = userBudget;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Set Budget'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Current Budget: \$${userBudget.toStringAsFixed(2)}'),
              TextFormField(
                initialValue: userBudget.toStringAsFixed(2),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  newBudget = double.tryParse(value) ?? userBudget;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  userBudget = newBudget;
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}

class CartScreen extends StatelessWidget {
  final Cart cart;

  CartScreen({required this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cart'),
        ),
        body: ListView.builder(
          itemCount: cart.items.length,
          itemBuilder: (context, index) {
            final cartItem = cart.items[index];
            return ListTile(
              title: Text('${cartItem.product.name}'),
              subtitle: Text(
                '\$${(cartItem.product.price * cartItem.quantity).toStringAsFixed(2)}',
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.remove_circle), // Use a delete icon
                    onPressed: () {
                      if (cartItem.quantity > 1) {
                        // If there are more than one of the same item, decrement quantity by 1
                        cartItem.quantity--;
                      } else {
                        // If there is only one item, remove it from the cart
                        cart.removeItem(cartItem);
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Removed ${cartItem.product.name} from cart',
                          ),
                          duration: Duration(seconds: 2),
                        ),
                      );

                      // No need to call any updateTotalPrice method, the total price will be recalculated on rebuild
                    },
                  ),
                  Text('${cartItem.quantity}x'), // Display the quantity
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Total: ${NumberFormat.currency(locale: 'en_ZA', symbol: 'R').format(cart.totalPrice)}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderForm(cart: cart),
                    ),
                  );
                },
                child: Text('Order Now'),
              ),
            ],
          ),
        ));
  }
}

class DeliveryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Cart(); // Initialize an empty cart

    return MaterialApp(
      title: 'Delivery App',
      home: OrderForm(cart: cart),
    );
  }
}

class OrderForm extends StatefulWidget {
  final Cart cart;

  OrderForm({required this.cart});

  @override
  _OrderFormState createState() => _OrderFormState();
}

enum DeliveryMethod { motorBike, car, plane, pickUp }

class _OrderFormState extends State<OrderForm> {
  PhoneNumber?
      selectedPhoneNumber; // Store the selected phone number and country code
  DeliveryMethod? selectedDeliveryMethod;

  Widget _buildDeliveryForm() {
    switch (selectedDeliveryMethod) {
      case DeliveryMethod.motorBike:
        return _buildMotorBikeForm();
      case DeliveryMethod.car:
        return _buildCarForm();
      case DeliveryMethod.plane:
        return _buildPlaneForm();
      case DeliveryMethod.pickUp:
        return _buildPickUpForm();
      default:
        return SizedBox.shrink(); // Hide the form by default
    }
  }

  Widget _buildMotorBikeForm() {
    final deliveryCharge = widget.cart.totalPrice * 0.20;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Motor Bike Form',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(
            'Delivery Charge: ${NumberFormat.currency(locale: 'en_ZA', symbol: 'R').format(deliveryCharge)}'),
        // Format delivery charge as Rands (ZAR)
        TextFormField(
          decoration: InputDecoration(labelText: 'Country/Region'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'First Name'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Last Name'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Address'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'City'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Postal Code'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Phone Number'),
        ),
      ],
    );
  }

  Widget _buildCarForm() {
    final deliveryCharge = widget.cart.totalPrice * 0.15;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Car Form',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(
            'Delivery Charge: ${NumberFormat.currency(locale: 'en_ZA', symbol: 'R').format(deliveryCharge)}'),
        // Format delivery charge as Rands (ZAR)
        TextFormField(
          decoration: InputDecoration(labelText: 'Country/Region'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'First Name'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Last Name'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Address'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'City'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Postal Code'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Phone Number'),
        ),
      ],
    );
  }

  Widget _buildPlaneForm() {
    final deliveryCharge = widget.cart.totalPrice * 0.10;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Plane Form',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(
            'Delivery Charge: ${NumberFormat.currency(locale: 'en_ZA', symbol: 'R').format(deliveryCharge)}'),
        // Format delivery charge as Rands (ZAR)
        TextFormField(
          decoration: InputDecoration(labelText: 'Country/Region'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'First Name'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Last Name'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Address'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'City'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Postal Code'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Phone Number'),
        ),
      ],
    );
  }

  Widget _buildPickUpForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Pick Up Form',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text('Delivery Charge: Free'), // Display "Free" for the delivery charge
        SizedBox(height: 16),
        Text(
          'Pick Up Location:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        // Display pickup location for each product in the cart
        ListView.builder(
          shrinkWrap: true,
          itemCount: widget.cart.items.length,
          itemBuilder: (context, index) {
            final cartItem = widget.cart.items[index];
            final product = cartItem.product;
            return ListTile(
              title: Text(product.name),
              subtitle: Text(
                'Pick Up Location: ${product.pickupLocation}',
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Form'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          SizedBox(height: 16),
          Text(
            'Contact:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          // Add a TextFormField for contact (email or mobile phone)
          InternationalPhoneNumberInput(
            onInputChanged: (PhoneNumber number) {
              setState(() {
                selectedPhoneNumber = number;
              });
            },
            selectorConfig: SelectorConfig(
              selectorType: PhoneInputSelectorType.DIALOG,
            ),
            hintText: 'Phone Number',
          ),
          SizedBox(height: 16),
          Text(
            'Shipping By:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          RadioListTile<DeliveryMethod>(
            title: Row(
              children: [
                Image.asset(
                  'assets/images/fast-delivery.png',
                  width: 30,
                ),
                SizedBox(width: 10),
                Text("Motor Bike"),
              ],
            ),
            value: DeliveryMethod.motorBike,
            groupValue: selectedDeliveryMethod,
            onChanged: (DeliveryMethod? value) {
              setState(() {
                selectedDeliveryMethod = value;
              });
            },
          ),
          RadioListTile<DeliveryMethod>(
            title: Row(
              children: [
                Image.asset(
                  'assets/images/shipped.png',
                  width: 30,
                ),
                SizedBox(width: 10),
                Text("Car"),
              ],
            ),
            value: DeliveryMethod.car,
            groupValue: selectedDeliveryMethod,
            onChanged: (DeliveryMethod? value) {
              setState(() {
                selectedDeliveryMethod = value;
              });
            },
          ),
          RadioListTile<DeliveryMethod>(
            title: Row(
              children: [
                Image.asset(
                  'assets/images/world.png',
                  width: 30,
                ),
                SizedBox(width: 10),
                Text("Plane"),
              ],
            ),
            value: DeliveryMethod.plane,
            groupValue: selectedDeliveryMethod,
            onChanged: (DeliveryMethod? value) {
              setState(() {
                selectedDeliveryMethod = value;
              });
            },
          ),
          RadioListTile<DeliveryMethod>(
            title: Row(
              children: [
                Image.asset(
                  'assets/images/location.png',
                  width: 30,
                ),
                SizedBox(width: 10),
                Text("Pick Up"),
              ],
            ),
            value: DeliveryMethod.pickUp,
            groupValue: selectedDeliveryMethod,
            onChanged: (DeliveryMethod? value) {
              setState(() {
                selectedDeliveryMethod = value;
              });
            },
          ),
          SizedBox(height: 16),
          if (selectedDeliveryMethod != null) _buildDeliveryForm(),
          SizedBox(height: 16),
          Text(
            'Your Cart:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.cart.items.length,
            itemBuilder: (context, index) {
              final cartItem = widget.cart.items[index];
              return ListTile(
                title: Text(cartItem.product.name),
                subtitle: Text(
                    'Quantity: ${cartItem.quantity} x \$${cartItem.product.price.toStringAsFixed(2)}'),
              );
            },
          ),
          SizedBox(height: 16),
          Text(
            'Total: ${NumberFormat.currency(locale: 'en_ZA', symbol: 'R').format(widget.cart.totalPrice + (selectedDeliveryMethod != null ? calculateDeliveryCharge() : 0.0))}', // Format total price as Rands (ZAR)
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Navigate to the PayPal payment page
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CheckoutPage(),
                ),
              );
            },
            child: Text('Checkout with PayPal'),
          ),
        ],
      ),
    );
  }

  double calculateDeliveryCharge() {
    switch (selectedDeliveryMethod) {
      case DeliveryMethod.motorBike:
        return widget.cart.totalPrice * 0.20;
      case DeliveryMethod.car:
        return widget.cart.totalPrice * 0.15;
      case DeliveryMethod.plane:
        return widget.cart.totalPrice * 0.10;
      case DeliveryMethod.pickUp:
        return 0.0;
      default:
        return 0.0;
    }
  }
}
