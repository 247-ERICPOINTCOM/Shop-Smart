import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase',
      home: ViewUploadedDataScreen(),
    );
  }
}

class ViewUploadedDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Product List"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Product Details').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return Center(
              child: Text('No data available'),
            );
          }

          final documents = snapshot.data!.docs;

          if (documents.isEmpty) {
            return Center(
              child: Text('No data available'),
            );
          }

          // Define the data columns for the DataTable
          final columns = [
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Description')),
            DataColumn(label: Text('Price')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('Date Added')),
            DataColumn(label: Text('Image')), // Add an Image
            DataColumn(label: Text('Store')),
            DataColumn(label: Text('Edit')), // Add an Edit column
          ];

          // Create a list of DataRow widgets
          final rows = documents.map<DataRow>((document) {
            final data = document.data() as Map<String, dynamic>?;

            if (data == null) {
              // Handle the case where data is null (e.g., document doesn't exist)
              return DataRow(cells: [
                DataCell(Container(width: 100, child: Text('No Data'))),
                DataCell(Container(width: 100, child: Text('No Data'))),
                DataCell(Container(width: 100, child: Text('No Data'))),
                DataCell(Container(width: 100, child: Text('No Data'))),
                DataCell(Container(width: 100, child: Text('No Data'))),
                DataCell(Container(width: 100, child: Text('No Data'))), // Provide a default value for the image
                DataCell(Container(width: 100, child: Text('No Data'))),
                DataCell(Container(width: 100, child: Text('No Data'))), // Provide a default value for the edit link
              ]);
            }

            final name = data['Name'] ?? 'No Name';
            final description = data['Description'] ?? 'No Description';
            final price = data['Price'] ?? 'No Price';
            final status = data['status'] ?? 'No Status';
            final dateAdded = data['date added'] ?? 'No Date Added';
            final imageUrl = data['Image'] ?? ''; // Provide a default value or handle this case
            final store = data['store'] ?? 'No Store';

            return DataRow(
              cells: [
                DataCell(Container(width: 100, child: Text(name))),
                DataCell(Container(width: 100, child: Text(description))),
                DataCell(Container(width: 100, child: Text(price))),
                DataCell(Container(width: 100, child: Text(status))),
                DataCell(Container(width: 100, child: Text(dateAdded))),
                DataCell(Container(width: 100, child: Text(store))),
                DataCell(Container(width: 100, child: Image.network(imageUrl))), // Display the image.
                DataCell(
                  Container(
                    width: 100,
                    child: GestureDetector(
                      onTap: () {
                        // Handle the edit action here
                        // You can navigate to an edit screen or show a dialog for editing
                        // For now, let's print a message
                        print('Edit link tapped for: $name');
                      },
                      child: Text('Edit', style: TextStyle(color: Colors.blue)),
                    ),
                  ),
                ),
              ],
            );
          }).toList();

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal, // Horizontal scrolling
            child: DataTable(
              columns: columns,
              rows: rows,
            ),
          );
        },
      ),
    );
  }
}

