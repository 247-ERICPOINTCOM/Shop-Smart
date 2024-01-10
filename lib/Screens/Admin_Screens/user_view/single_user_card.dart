import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Object_Clasess/user_model.dart';
import '../../../provider/app_provider.dart';

class SingleUserCard extends StatefulWidget {
  final UserModel userModel;
  final int index;

  const SingleUserCard(
      {super.key, required this.userModel, required this.index});

  @override
  State<SingleUserCard> createState() => _SingleUserCardState();
}

class _SingleUserCardState extends State<SingleUserCard> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            widget.userModel.userImage != null
                ? CircleAvatar(
                    backgroundImage: NetworkImage(widget.userModel.userImage!),
                    //child: Icon(Icons.person),
                  )
                : CircleAvatar(
                    child: Icon(Icons.person),
                  ),
            SizedBox(
              width: 12.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.userModel.userEmail),
              ],
            ),
            Spacer(),
            isLoading
                ? CircularProgressIndicator()
                : GestureDetector(
                    //padding: EdgeInsets.zero,
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await appProvider
                          .deleteUserFromFirebase(widget.userModel);
                      setState(() {
                        isLoading = false;
                      });
                    },
                    child: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
            SizedBox(
              width: 6.0,
            ),
            // GestureDetector(
            //   //padding: EdgeInsets.zero,
            //   onTap: () async {
            //     Routes.instance.push(
            //         widget: EditUser(
            //             index: widget.index, userModel: widget.userModel),
            //         context: context);
            //   },
            //   child: Icon(
            //     Icons.edit,
            //     color: Colors.black,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
