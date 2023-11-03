import 'package:flutter/material.dart';
import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopsmartly/Screens/Admin_Screens/Add_Order.dart';
import 'package:shopsmartly/Screens/Admin_Screens/DeliveryEditStatus.dart';
import 'package:shopsmartly/my_flutter_app_icons.dart';

import '../../Object_Clasess/Order.dart';
import 'Menubar_Admin.dart';
const kPrimaryColor = Color(0xFFB4D677);
const kPrimaryLightColor = Color(0xFFA0D1C6);
const kBackgroundColor = Color(0xFFF7F7F7);
const kTextColor = Color(0xFFa0a0a0);
const kInputColor = Color(0xFFe3e3e3);
const kRedColor = Color(0xFFE88276);
const kyellowColor = Color(0xFFF5d287);
const kBlackColor = Color(0xFF000000);
int index= 0;

class Delivery_List extends StatefulWidget {
  var newOrder;
  Delivery_List({super.key, 
    this.newOrder
  });
  @override
  State<Delivery_List> createState() => _Delivery_ListState();
}

class _Delivery_ListState extends State<Delivery_List> {

  final OderList = <Order>[
    const Order(orderID: 97389, customerId: 31845, driverName: 'jhons mith', carNumber: 'vbd123',orderStatus: 'Processing' ,orderdate: '30/6/2022'),
    const Order(orderID: 18603, customerId: 68968 , driverName: 'Ireland Gardner', carNumber: 'HPD8527',orderStatus: 'Shipped' ,orderdate: '12/3/2022'),
    const Order(orderID: 99782, customerId: 56890, driverName: 'Colten Murray', carNumber: 'VTJ5667',orderStatus: 'Processing' ,orderdate: '17/8/2022'),
    const Order(orderID: 98418, customerId: 09950, driverName: 'Melvin Gonzalez', carNumber: 'GWK9924',orderStatus: 'Delivered' ,orderdate: '14/2/2022'),
    const Order(orderID: 45499, customerId: 61690, driverName: 'Travis Huerta', carNumber: '7AAA774',orderStatus: 'Shipped' ,orderdate: '19/5/2022'),
    const Order(orderID: 55656, customerId: 19575, driverName: 'Paloma Thornton', carNumber: 'KVT7677',orderStatus: 'Processing' ,orderdate: '6/6/2022'),
    const Order(orderID: 29782, customerId: 51230, driverName: 'Kendra Riley', carNumber: 'HFNW59',orderStatus: 'Delivered' ,orderdate: '16/9/2022'),
    const Order(orderID: 22925, customerId: 88174, driverName: 'Rayna King', carNumber: 'HHU6737',orderStatus: 'Blocked' ,orderdate: '24/2/2022'),
    const Order(orderID: 93460, customerId: 28915 , driverName: 'Connor Savage', carNumber: '8AAV633',orderStatus: 'Shipped' ,orderdate: '28/11/2022'),
    const Order(orderID: 123345, customerId: 54321, driverName: 'Yasmine Hamilton', carNumber: '8AYH243',orderStatus: 'Blocked' ,orderdate: '22/2/2022'),
  ].toList();
  late List<Order> Listorder;

  @override
  void initState() {
    super.initState();

    Listorder = List.of(OderList);
  }
  @override
  Widget build(BuildContext context) {
    final verticalScrollController = ScrollController();
    final horizontalScrollController = ScrollController();

    Future newOrder;
    return Scaffold(
        backgroundColor: kBackgroundColor,
        drawer:const Menubar_Admin(),
        appBar: AppBar(
          backgroundColor: kPrimaryLightColor,
        ),
        body: ListView(
            children: <Widget>[

              Container(
                child: Row(
                    children: [
                      const SizedBox(height: 80),
                      const SizedBox(width: 50),
                      const Text("Order List:", style: TextStyle(
                          fontSize: 25.0,
                          color: kBlackColor,
                          fontWeight: FontWeight.bold)),
                      const SizedBox(width: 180),
                      IconButton(onPressed:() async {
                        newOrder=
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const Add_Order()));
                        // Listorder.add(newOrder);

                      }, icon:const Icon(MyFlutterApp.add, size: 35,)),


                    ]


                ),
              ),


// ------------ building the table------
              SizedBox(
                height: 600,
                width: 700,
                child: AdaptiveScrollbar(
                  underColor: const Color(0xFFA0D1C6).withOpacity(0.3),
                  sliderDefaultColor: const Color(0xFFA0D1C6).withOpacity(0.7),
                  sliderActiveColor: const Color(0xFFA0D1C6),
                  controller: verticalScrollController,
                  child: AdaptiveScrollbar(
                    controller: horizontalScrollController,
                    position: ScrollbarPosition.bottom,
                    underColor: const Color(0xFFA0D1C6).withOpacity(0.3),
                    sliderDefaultColor:const Color(0xFFA0D1C6).withOpacity(0.7),
                    sliderActiveColor: const Color(0xFFA0D1C6),
                    child: SingleChildScrollView(
                      controller: verticalScrollController,
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        controller: horizontalScrollController,
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0, bottom: 16.0),
                          child: buildDataTable(),


                        ),
                      ),
                    ),
                  ),
                ),
              ),


            ]
        )

    );
  }//main wedget



  //-----------The table Method---------
  Widget buildDataTable(){

    return DataTable(
        showCheckboxColumn: false,
        columns:  const [
          DataColumn(
            label: Text('Customer ID'),
          ),
          DataColumn(
            label: Text('Order Id'),
          ),
          DataColumn(
            label: Text('Driver Name'),
          ),
          DataColumn(
            label: Text('Car Number'),
          ),
          DataColumn(
            label: Text('Status'),
          ),
          DataColumn(
            label: Text('Edit'),
          ),
          DataColumn(
            label: Text('Delete'),
          ),
        ],//columns
        rows: //getRows(OderList));
        List<DataRow>.generate(Listorder.length,
              (index) => DataRow(
            cells: <DataCell>[
              DataCell(

                Text(Listorder[index].customerId.toString()),
              ),
              DataCell(
                  Text(Listorder[index].orderID.toString()),
                  onTap:() {
                    print('its tapperees');
                    print(index);
                    setState(() {
                      showModalBottomSheet(context: context, builder: (context)=>buildSheet()
                          ,shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(30))
                          )); //show
                    });    //set state
                  }//on tapp
              ),
              DataCell(
                Text(Listorder[index].driverName),
              ),
              DataCell(
                Text(Listorder[index].carNumber),
              ),
              DataCell(
                Text(Listorder[index].orderStatus),
              ),
              DataCell(
                  IconButton(onPressed:()async{

                    final newStatus =
                    await Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const DeliveryEditStatus()));
                    //this the error here first the data pss successfully but i wouldn't modify at rhe object even if i do it with the replace method
                    print(newStatus);
                    print( Listorder[index].orderStatus.replaceAll(Listorder[index].orderStatus, newStatus));//i use replace method to modify it
                    print(Listorder[index].orderStatus);//but still store the old status
                  }, icon:const Icon(MyFlutterApp.edit_1, size: 20,))
              ),
              DataCell(
                CupertinoButton(child:const Icon(MyFlutterApp.trash_alt, size: 20,color: kBlackColor,),

                    onPressed: ()async{

                      final isYes= await showCupertinoDialog(context: context, builder: createDialog);
                      setState(() {
                        Listorder.removeAt(index);
                      });

                    }),
                //IconButton(onPressed:(){},


              ),

            ],
            onSelectChanged: (bool? value) {},
          ),
        )
    );


  }//build data table



  //-------------- the Delete Method----------------
  Widget createDialog(BuildContext context)=> CupertinoAlertDialog(
      title  : const Text('Are you sure you want delete “order ID :” '),
      actions: [
        CupertinoDialogAction(child: const Text('Delete'),onPressed: (){Navigator.pop(context,true);
        },),
        CupertinoDialogAction(child: const Text('Cancle'),onPressed: (){  Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Delivery_List(),
        ));
        },),
      ]
  );

//-----------show order details Method ---------
  /*
    *This data is Empty because we didn't build the database
    that will build the integration  between  customers class order ,class and driver class
    * you can fill this data after building the database
    */
  Widget buildSheet()=> const Column(
    children: [
      SizedBox(height: 15,),
      Text("Customer ID:"),
      SizedBox(height: 10,),
      Text("Customer Name:"),
      SizedBox(height: 10,),
      Text("Driver ID : "),
      SizedBox(height: 10,),
      Text("Driver Name : "),
      SizedBox(height: 10,),
      Text("Cer Number : "),
      SizedBox(height: 10,),
      Text("Total product number:"),
      SizedBox(height: 10,),
      Text("Total price:"),
      SizedBox(height: 10,),
      Text("Date :"),
      SizedBox(height: 10,),
      Text("Status :"),
      SizedBox(height: 10,),
      SizedBox(height: 80,width: 140 ,child: Icon(MyFlutterApp.truck,size: 80,color:kRedColor ,),),
    ],//column children

  );}
