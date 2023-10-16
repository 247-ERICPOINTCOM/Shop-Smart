import 'package:flutter/material.dart';
import 'package:shopsmartly/Object_Clasess/Order.dart';
import 'package:shopsmartly/my_flutter_app_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'Delivery_List.dart';
const kPrimaryColor = Color(0xFFB4D677);
const kPrimaryLightColor = Color(0xFFA0D1C6);
const kBackgroundColor = Color(0xFFF7F7F7);
const kTextColor = Color(0xFFa0a0a0);
const kInputColor = Color(0xFFe3e3e3);
const kRedColor = Color(0xFFE88276);
const kyellowColor = Color(0xFFF5d287);
const kBlackColor = Color(0xFF000000);

//final status=['Status','Processing ','Shipped','Blocked','Delivered'];
class DeliveryEditStatus extends StatefulWidget {



  const DeliveryEditStatus ( {Key? key}) : super(key: key);


  @override
  State<DeliveryEditStatus> createState() => _DeliveryEditStatus();
}

class _DeliveryEditStatus extends State<DeliveryEditStatus> {
  var value;
  final status = [
    'Processing ',
    'Shipped',
    'Blocked',
    'Delivered'
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => Delivery_List()));
        }, icon: const Icon(MyFlutterApp.arrow_left, size: 20,)),
        backgroundColor: kPrimaryLightColor,
      ),

      body:

      Center(
        child:  ListView(

          padding: const EdgeInsets.all(32),
          children: [
            const SizedBox(height: 15),
            Icon(MdiIcons.truckDelivery,size: 200,color: kPrimaryLightColor ,),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
                  border:Border.all(color:kBlackColor,width: 0.5)),
              padding: const EdgeInsets.all(20),
              child: const Column(
                children: [

                  Text("Customer ID:"),
                  Text("Order ID:"),
                  Text("Driver Name : "),
                  Text("Order Date :"),
                ],
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
              child:  DropdownButton <String>(
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
                        )),// ElevatedButton.styleFrom(primary: kPrimaryColor, minimumSize: Size(100,30)),
                    onPressed: ()=> Navigator.of(context).pop(value),
                    child: const Text('OK',style: TextStyle(fontWeight: FontWeight.bold),)
                )
            ),

          ],//coiumn chlidren
        ),
      ),
    );//Scaffold
  }//build
  DropdownMenuItem <String> buildMenuItem(String status) =>
      DropdownMenuItem(
        value: status,
        child: Text(status, style: const TextStyle(
            fontSize: 12.0,
            color: kBlackColor,
            fontWeight: FontWeight.bold),),
      );

  Order get getorderEdit {
    return getorderEdit;
  }
// setter:  	set field_name {  }
  set setorderEdit(Order order) {
    setorderEdit = order;
  }
}//class

