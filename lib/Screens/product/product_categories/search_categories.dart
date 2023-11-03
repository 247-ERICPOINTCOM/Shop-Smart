import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopsmartly/Object_Clasess/product_model.dart';
import 'package:shopsmartly/Screens/side_drawer/side_drawer.dart';
import 'package:shopsmartly/constants/constants.dart';
import '../../camera/camera.dart';
import 'widgets/single_dash_item.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController search = TextEditingController();
  List<ProductModel> searchList = [];

  // void searchProducts(String value) {
  //   searchList = productModelList
  //       .where((element) =>
  //       element.name.toLowerCase().contains(value.toLowerCase()))
  //       .toList();
  //   setState(() {});
  // }

  @override
  void initState() {
    super.initState();
    }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;

     // void getData() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
  //   await appProvider.callBackFunction();
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  // @override
  // void initState() {
  //   getData();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () async {
            await availableCameras().then(
              (value) => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => CameraPage(cameras: value))),
            );
          },
          icon: Icon(
            Icons.image_search,
            color: kPrimaryLightColor,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
              icon: Icon(
                Icons.list_outlined,
                color: kPrimaryLightColor,
              ))
        ],
        title: Container(
          padding: EdgeInsets.all(12),
          child: TextFormField(
            controller: search,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kPrimaryLightColor),
                borderRadius: BorderRadius.circular(15),
              ),
              isDense: true,
              contentPadding: EdgeInsets.all(10),
              filled: false,
              hintText: "Search",
              fillColor: kPrimaryColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              suffixIcon: Icon(
                Icons.search,
                size: 30,
              ),
            ),
          ),
        ),
      ),
      endDrawer: SideDrawer(),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(12),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GridView.count(
                      shrinkWrap: true,
                      primary: false,
                      padding: EdgeInsets.zero,
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: (1.5),
                      children: [
                        SingleCardItem(
                          title: "Home",
                          onPressed: () {
                            // Routes.instance.push(
                            //   widget: UserView(),
                            //   context: context,
                            // );
                          },
                        ),
                        SingleCardItem(
                          title: "Groceries",
                          onPressed: () {
                            // Routes.instance.push(
                            //   widget: UserView(),
                            //   context: context,
                            // );
                          },
                        ),
                        SingleCardItem(
                          title: "Ticket",
                          onPressed: () {
                            // Routes.instance.push(
                            //   widget: CategoriesView(),
                            //   context: context,
                            // );
                          },
                        ),
                        SingleCardItem(
                          title: "Cars",
                          onPressed: () {
                            // Routes.instance.push(
                            //   widget: CategoriesView(),
                            //   context: context,
                            // );
                          },
                        ),
                        SingleCardItem(
                          title: "Electronics",
                          onPressed: () {
                            // Routes.instance.push(
                            //   widget: CategoriesView(),
                            //   context: context,
                            // );
                          },
                        ),
                        SingleCardItem(
                          title: "Men",
                          onPressed: () {
                            // Routes.instance.push(
                            //   widget: ProductView(),
                            //   context: context,
                            // );
                          },
                        ),
                        SingleCardItem(
                          title: "Women",
                          onPressed: () {},
                        ),
                        SingleCardItem(
                          title: "Kids",
                          onPressed: () {
                            // Routes.instance.push(
                            //   widget: OrderList(
                            //     title: "Pending",
                            //   ),
                            //   context: context,
                            // );
                          },
                        ),
                        SingleCardItem(
                          title: "Toys",
                          onPressed: () {
                            // Routes.instance.push(
                            //   widget: OrderList(
                            //     title: "Delivery",
                            //   ),
                            //   context: context,
                            // );
                          },
                        ),
                        SingleCardItem(
                          title: "Accessories",
                          onPressed: () {
                            // Routes.instance.push(
                            //   widget: OrderList(
                            //     title: "Cancelled",
                            //   ),
                            //   context: context,
                            // );
                          },
                        ),
                        SingleCardItem(
                          title: "Tools",
                          onPressed: () {
                            // Routes.instance.push(
                            //   widget: OrderList(
                            //     title: "Completed",
                            //   ),
                            //   context: context,
                            // );
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 60,
                    )
                  ],
                ),
              ),
            ),
    );
  }

  bool isSearched() {
    if (search.text.isNotEmpty && searchList.isEmpty) {
      return true;
    } else if (search.text.isEmpty && searchList.isNotEmpty) {
      return false;
    } else if (search.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
