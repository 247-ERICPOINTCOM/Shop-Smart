import 'package:flutter/material.dart';
import 'package:shopsmartly/Screens/BusinessOwner_Screens/Dashboard_BO.dart';
import 'package:shopsmartly/Screens/BusinessOwner_Screens/Menubar_BO.dart';
const kPrimaryColor = Color(0xFFB4D677);
const kPrimaryLightColor = Color(0xFFA0D1C6);
const kBackgroundColor = Color(0xFFF7F7F7);
const kTextColor = Color(0xFFa0a0a0);
const kInputColor = Color(0xFFe3e3e3);
const kRedColor = Color(0xFFE88276);
const kyellowColor = Color(0xFFF5d287);
const kBlackColor = Color(0xFF000000);

class Help_BO extends StatelessWidget {
  const Help_BO({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: const Menubar_BO(),
      backgroundColor: kBackgroundColor,
      appBar: AppBar(

        backgroundColor: kPrimaryLightColor,
      ),
      body: ListView(
        padding: const EdgeInsets.all(32),
        children:[
          const SizedBox(height:15,),
          const Text('How we can help you !',style: TextStyle(
              fontSize: 25.0,
              color: kBlackColor,
              fontWeight: FontWeight.bold),),
          const SizedBox(height: 10),
          const Text('Plese Enter your information: ',style: TextStyle(
              fontSize: 18.0,
              color: kBlackColor,
              fontWeight: FontWeight.bold),),
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
          const Text("Note :", style: TextStyle(
              fontSize: 15.0,
              color: kBlackColor,
              fontWeight: FontWeight.bold),),
          const SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
                isDense: true,                      // Added this
                contentPadding: const EdgeInsets.all(70),
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
                    builder: (context) => const Dashboard_BO(),
                  )),
                  child: const Text('Send',style: TextStyle(fontWeight: FontWeight.bold),)


              )
          ),


        ],
      ),
    );
  }
}