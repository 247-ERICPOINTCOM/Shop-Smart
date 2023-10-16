import 'package:flutter/material.dart';
import 'package:shopsmartly/Screens/Admin_Screens/Users_List.dart';
import 'package:shopsmartly/my_flutter_app_icons.dart';

const kPrimaryColor = Color(0xFFB4D677);
const kPrimaryLightColor = Color(0xFFA0D1C6);
const kBackgroundColor = Color(0xFFF7F7F7);
const kTextColor = Color(0xFFa0a0a0);
const kInputColor = Color(0xFFe3e3e3);
const kRedColor = Color(0xFFE88276);
const kyellowColor = Color(0xFFF5d287);
const kBlackColor = Color(0xFF000000);

//final status=['Status','Processing ','Shipped','Blocked','Delivered'];
class Edit_User extends StatefulWidget {


  const Edit_User  ({Key? key}) : super(key: key);


  @override
  State<Edit_User> createState() => _Edit_UserState();
}

class _Edit_UserState extends State<Edit_User> {

  var value;
  final  status = [
    'Active',
    'Not-Active',' Blocked'
  ];


  @override
  Widget build(BuildContext context){
    return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          leading: IconButton(onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const UserListScreen()));
          }, icon: const Icon(MyFlutterApp.arrow_left, size: 20,)),
          backgroundColor: kPrimaryLightColor,
        ),
        body: ListView(
          padding: const EdgeInsets.all(32),
          children: [
            const SizedBox(height: 25),
            const Text("Edit User:", style: TextStyle(
                fontSize: 20.0,
                color: kBlackColor,
                fontWeight: FontWeight.bold),),
            const SizedBox(height: 15),
            const Text("User ID:", style: TextStyle(
                fontSize: 15.0,
                color: kBlackColor,
                fontWeight: FontWeight.bold),),
            const SizedBox(height: 10),
            TextField(

              decoration: InputDecoration(
                  labelStyle: const TextStyle(color: kBlackColor),

                  enabledBorder: OutlineInputBorder
                    (borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: kBlackColor),),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: kBlackColor)
                  )
              ),
            ),
            const SizedBox(height: 15),
            const Text("User Name:", style: TextStyle(
                fontSize: 15.0,
                color: kBlackColor,
                fontWeight: FontWeight.bold),),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                  labelStyle: const TextStyle(color: kBlackColor),

                  enabledBorder: OutlineInputBorder
                    (borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: kBlackColor),),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: kBlackColor)
                  )
              ),
            ),
            const SizedBox(height: 15),
            const Text("Email:", style: TextStyle(
                fontSize: 15.0,
                color: kBlackColor,
                fontWeight: FontWeight.bold),),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                  labelStyle: const TextStyle(color: kBlackColor),

                  enabledBorder: OutlineInputBorder
                    (borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: kBlackColor),),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: kBlackColor)
                  )
              ),
            ),
            const SizedBox(height: 15),
            const SizedBox(height: 15),
            const Text("Phone Number :", style: TextStyle(
                fontSize: 15.0,
                color: kBlackColor,
                fontWeight: FontWeight.bold),),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                  labelStyle: const TextStyle(color: kBlackColor),

                  enabledBorder: OutlineInputBorder
                    (borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: kBlackColor),),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: kBlackColor)
                  )
              ),
            ),
            const SizedBox(height: 15),
            const SizedBox(height: 15),
            const Text("Address:", style: TextStyle(
                fontSize: 15.0,
                color: kBlackColor,
                fontWeight: FontWeight.bold),),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                  labelStyle: const TextStyle(color: kBlackColor),

                  enabledBorder: OutlineInputBorder
                    (borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: kBlackColor),),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: kBlackColor)
                  )
              ),
            ),
            const SizedBox(height: 15),
            const Text("Status", style: TextStyle(
                fontSize: 15.0,
                color: kBlackColor,
                fontWeight: FontWeight.bold),),
            const SizedBox(height: 10),
            Container(

              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: kBlackColor)
              ),
              child: DropdownButton <String>(
                isExpanded: true,
                value:value,

                items: status.map((buildMenuItem){
                  return DropdownMenuItem(
                    value: buildMenuItem,
                    child: Center(child: Text(buildMenuItem)),);
                }).toList(),
                onChanged:(value) => setState(() => this.value = value!),
                icon: const Icon(MyFlutterApp.arrow_circle_down, size: 25,),


              ),
            ),
            const SizedBox(height: 15),
            SizedBox(height:60
                , width: 40,
                child: ElevatedButton(
                    style:ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor)
                        ,shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            )
                        )),

                    onPressed: ()=> Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const UserListScreen(),
                    )),
                    child: const Text('OK',style: TextStyle(fontWeight: FontWeight.bold),)


                )
            ),

          ], //children,

        )

    );
  }

  DropdownMenuItem <String> buildMenuItem(String status) =>
      DropdownMenuItem(
        value: status,
        child: Text(status, style: const TextStyle(
            fontSize: 12.0,
            color: kBlackColor,
            fontWeight: FontWeight.bold),),
      );
}
