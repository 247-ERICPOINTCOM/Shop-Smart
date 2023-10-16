import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(const MaterialApp(
    home: UserListScreen(),
  ));
}

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final CollectionReference usersCollection =
  FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: usersCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error loading data'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final users = snapshot.data?.docs;

          if (users == null || users.isEmpty) {
            return const Center(
              child: Text('No users found.'),
            );
          }

          return DataTable(
            columns: const [
              DataColumn(label: Text('UID')),
              DataColumn(label: Text('Username')),
              DataColumn(label: Text('Email')),
              DataColumn(label: Text('UserType')),
            ],
            rows: users.map((userDoc) {
              final userUID = userDoc.id; // Get the user's UID
              final username = userDoc['username'] ?? 'N/A';
              final email = userDoc['email'] ?? 'N/A';
              final userType = userDoc['userType'] ?? 'N/A';

              return DataRow(
                cells: [
                  DataCell(Text(userUID)),
                  DataCell(Text(username)),
                  DataCell(Text(email)),
                  DataCell(Text(userType)),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
