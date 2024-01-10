import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmartly/Object_Clasess/user_model.dart';
import 'package:shopsmartly/provider/app_provider.dart';
import 'single_user_card.dart';

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Information"),
      ),
      body: Consumer<AppProvider>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.getUserList.length,
            padding: EdgeInsets.all(12),
            itemBuilder: (context, index) {
              UserModel userModel = value.getUserList[index];
              return SingleUserCard(
                userModel: userModel,
                index: index,
              );
            },
          );
        },
      ),
    );
  }
}
