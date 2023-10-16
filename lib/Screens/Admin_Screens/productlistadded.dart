import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Productslist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Product Details').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final products = snapshot.data!.docs;

          if (products.isEmpty) {
            return Center(
              child: Text('No products available.'),
            );
          }

          // Group products by BusinessOwnerID
          Map<String, List<DocumentSnapshot>> groupedProducts = {};

          products.forEach((product) {
            final businessOwnerID = product['BusinessOwnerID'] as String;

            if (!groupedProducts.containsKey(businessOwnerID)) {
              groupedProducts[businessOwnerID] = [];
            }

            groupedProducts[businessOwnerID]!.add(product);
          });

          return ListView(
            children: groupedProducts.entries.map((entry) {
              final businessOwnerID = entry.key;
              final businessOwnerProducts = entry.value;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Business Owner: $businessOwnerID',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: businessOwnerProducts.length,
                    itemBuilder: (context, index) {
                      final product = businessOwnerProducts[index];
                      final productName = product['Name'] as String;
                      final productDescription = product['Description'] as String;
                      final productPrice = product['Price'] as double;

                      return ListTile(
                        title: Text(productName),
                        subtitle: Text(productDescription),
                        trailing: Text('\$$productPrice'),
                      );
                    },
                  ),
                  Divider(),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Productslist(),
  ));
}
