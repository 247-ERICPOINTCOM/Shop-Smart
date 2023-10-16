import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopsmartly/Screens/BusinessOwner_Screens/Menubar_BO.dart';

const kPrimaryColor = Color(0xFFB4D677);
const kPrimaryLightColor = Color(0xFFA0D1C6);
const kBackgroundColor = Color(0xFFF7F7F7);
const kTextColor = Color(0xFF000000); // Change text color to black
const kInputColor = Color(0xFFe3e3e3);
const kRedColor = Color(0xFFE88276);
const kyellowColor = Color(0xFFF5d287);
const kBlackColor = Color(0xFF000000);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class Dashboard_BO extends StatelessWidget {
  const Dashboard_BO({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    CollectionReference orders = _firestore.collection('orders'); // Replace with your collection name

    return Scaffold(
      drawer: const Menubar_BO(),
      backgroundColor: Colors.grey, // Change the background color to grey
      appBar: AppBar(
        backgroundColor: Colors.green, // Change the app bar color to green
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Container(
            child: ListView(
              children: [
                const SizedBox(height: 10),
                // Dashboard Title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Dashboard',
                    style: TextStyle(
                      fontSize: 30.0,
                      color: kBlackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Boxes for New Orders, New Sales, Total Accounts, and Total Products
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildDashboardBox(context, 'New Orders', ''),
                      _buildDashboardBox(context, 'New Sales', ''),
                      _buildDashboardBox(context, 'Total Accounts', ''),
                      _buildDashboardBox(context, 'Total Products', ''),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Today's Transactions Table
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: kInputColor,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            "Today's Transactions",
                            style: TextStyle(
                              fontSize: 25.0,
                              color: kBlackColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SingleChildScrollView( // Wrap the DataTable with SingleChildScrollView
                          scrollDirection: Axis.horizontal,
                          // Set the scroll direction to horizontal
                          child: StreamBuilder<QuerySnapshot>(
                            stream: orders.snapshots(), // Listen for changes in the collection
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return CircularProgressIndicator(); // Show a loading indicator while fetching data
                              }
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }

                              // Define the table columns even if there's no data yet
                              List<DataColumn> columns = [
                                DataColumn(label: Text('Order #')),
                                DataColumn(label: Text('Customer')),
                                DataColumn(label: Text('Products')),
                                DataColumn(label: Text('Total')),
                                DataColumn(label: Text('Date')),
                              ];

                              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                                // If there's no data, display the table with columns only
                                return DataTable(columns: columns, rows: []);
                              }

                              // Map the data to DataRow widgets
                              List<DataRow> dataRows = snapshot.data!.docs.map((doc) {
                                Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                                return DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text(data['orderNumber'])),
                                    DataCell(Text(data['customer'])),
                                    DataCell(Text(data['products'])),
                                    DataCell(Text('\$${data['total']}')),
                                    DataCell(Text(data['date'])),
                                  ],
                                );
                              }).toList();

                              return DataTable(
                                columns: columns,
                                rows: dataRows,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDashboardBox(BuildContext context, String title, String value) {
    return Container(
      height: 100,
      width: (MediaQuery
          .of(context)
          .size
          .width - 60) / 4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white, // Change the box color to white
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 20.0,
                  color: kBlackColor, // Change text color to black
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 20.0,
                  color: kBlackColor, // Change text color to black
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Name',
      theme: ThemeData(
        primarySwatch: Colors.green, // Change the primary color to green
      ),
      home: Dashboard_BO(),
    );
  }
}
