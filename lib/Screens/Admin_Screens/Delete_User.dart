import 'package:flutter/material.dart';
import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopsmartly/Object_Clasess/User.dart';
import 'package:shopsmartly/my_flutter_app_icons.dart';
import 'package:shopsmartly/Screens/Admin_Screens/productlistadded.dart';
import 'Users_List.dart';
const kPrimaryColor = Color(0xFFB4D677);
const kPrimaryLightColor = Color(0xFFA0D1C6);
const kBackgroundColor = Color(0xFFF7F7F7);
const kTextColor = Color(0xFFa0a0a0);
const kInputColor = Color(0xFFe3e3e3);
const kRedColor = Color(0xFFE88276);
const kyellowColor = Color(0xFFF5d287);
const kBlackColor = Color(0xFF000000);
int index= 0;

class Delete_User extends StatefulWidget {
  const Delete_User({super.key});


  @override
  State<Delete_User> createState() => _Delete_UserState();
}

class _Delete_UserState extends State<Delete_User> {


  late List<User> ListOfUser;

  @override
  void initState() {
    super.initState();

    //ListOfUser = List.of(DeletedUserList);
  }
  @override
  Widget build(BuildContext context) {
    final verticalScrollController = ScrollController();
    final horizontalScrollController = ScrollController();

    Future newOrder;
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
            children: <Widget>[

              Container(
                child: const Row(
                    children: [
                      SizedBox(height: 80),
                      SizedBox(width: 35),
                      Text("Deleted Users :", style: TextStyle(
                          fontSize: 25.0,
                          color: kBlackColor,
                          fontWeight: FontWeight.bold)),
                      SizedBox(width: 180),



                    ]


                ),
              ),

              const Divider(
                color: Colors.black,

              ),
// ------------ building the table------
              SizedBox(
                height: 800,
                width: 700,
                child: AdaptiveScrollbar(
                  underColor:  const Color(0xFFA0D1C6).withOpacity(0.3),
                  sliderDefaultColor:  const Color(0xFFA0D1C6).withOpacity(0.7),
                  sliderActiveColor:  const Color(0xFFA0D1C6),
                  controller: verticalScrollController,
                  child: AdaptiveScrollbar(
                    controller: horizontalScrollController,
                    position: ScrollbarPosition.bottom,
                    underColor:  const Color(0xFFA0D1C6).withOpacity(0.3),
                    sliderDefaultColor:  const Color(0xFFA0D1C6).withOpacity(0.7),
                    sliderActiveColor:  const Color(0xFFA0D1C6),
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
            label: Text('User ID'),
          ),
          DataColumn(
            label: Text('User Name'),
          ),
          DataColumn(
            label: Text('User Status'),
          ),
          DataColumn(
            label: Text('return user'),
          ),
          DataColumn(
            label: Text('Delet'),
          ),
        ],//columns
        rows: //getRows(OderList));
        List<DataRow>.generate(ListOfUser.length,
              (index) => DataRow(
            cells: <DataCell>[
              DataCell(

                Text(ListOfUser[index].userID.toString()),
              ),
              DataCell(
                Text(ListOfUser[index].userName),

              ),
              DataCell(
                Text(ListOfUser[index].userStatus),
              ),

              DataCell(
                  IconButton(onPressed:()async{
                    //should here add this user to the list
                    await Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const UserListScreen()));
                  }, icon:const Icon(MyFlutterApp.assignment_return, size: 30,))
              ),
              DataCell(
                CupertinoButton(child:const Icon(MyFlutterApp.trash_alt, size: 20,color: kBlackColor,),

                    onPressed: ()async{

                      final isYes= await showCupertinoDialog(context: context, builder: createDialog);
                      setState(() {
                        //method to set this user in deleted table
                        ListOfUser.removeAt(index);
                      });

                    }),



              ),

            ],
            onSelectChanged: (bool? value) {},
          ),
        )
    );


  }//build data table



  //-------------- the Delete Method----------------
  Widget createDialog(BuildContext context)=> CupertinoAlertDialog(
      title  : const Text('Are you sure you want delete the User '),
      actions: [
        CupertinoDialogAction(child: const Text('Delete'),onPressed: (){Navigator.pop(context,true);
        },),
        CupertinoDialogAction(child: const Text('Cancle'),onPressed: (){  Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const Delete_User(),
        ));
        },),
      ]
  );









}//class