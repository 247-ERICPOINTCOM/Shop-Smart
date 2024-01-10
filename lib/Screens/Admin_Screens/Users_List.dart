import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopsmartly/Screens/Admin_Screens/Delete_User.dart';
import 'package:shopsmartly/Screens/Admin_Screens/Edit_User.dart';
import 'package:shopsmartly/constants/constants.dart';

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
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
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

          return SingleChildScrollView(
            scrollDirection: Axis.vertical, // Make it vertically scrollable
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              // Make it horizontally scrollable
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Username')),
                  DataColumn(label: Text('Email')),
                  DataColumn(label: Text('UserType')),
                  DataColumn(label: Text('Edit')), // Add a column for actions
                  DataColumn(label: Text('Delete')),
                ],
                rows: users.map((userDoc) {
                  final Map<String, dynamic>? data = userDoc.data() as Map<String, dynamic>?;

                  if (data == null) {
                    return DataRow(cells: [DataCell(Text('Invalid Data'))]);
                  }

                  final username = data.containsKey('username') ? data['username'] : 'N/A';
                  final email = data.containsKey('email') ? data['email'] : 'N/A';
                  final userType = data.containsKey('userType') ? data['userType'] : 'N/A';

                  return DataRow(
                    cells: [
                      DataCell(Text('$username')),
                      DataCell(Text('$email')),
                      DataCell(Text('$userType')),
                      DataCell(
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const Edit_User(),
                            ));
                          },
                        ),
                      ),
                      DataCell(
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            // Handle delete button click
                            // You can show a confirmation dialog and delete the user.
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const Edit_User(),
                            ));

                          },
                        ),
                      )
                    ],
                  );
                }).toList(),

              ),
            ),
          );
        },
      ),
    );
  }
}
