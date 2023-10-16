import 'package:flutter/material.dart';
import 'package:shopsmartly/constants/constants.dart';
import 'widgets/single_dash_item.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.image_search),
        ),
        actions: [
          IconButton(
              onPressed: () {
                // logOut(context);
              },
              icon: Icon(Icons.list_outlined))
        ],
        title: Container(
          //padding: EdgeInsets.all(12),
          child: TextFormField(
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.all(10),
              filled: true,
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
                  ],
                ),
              ),
            ),
    );
  }
}
