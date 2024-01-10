import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Object_Clasess/category_model.dart';
import '../../Object_Clasess/product_model.dart';
import '../../constants/routes.dart';
import '../../firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import '../../provider/app_provider.dart';
import '../category_view/category_view.dart';
import '../product_details/product_details.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categoriesList = [];
  List<ProductModel> productModelList = [];
  bool isLoading = false;

  @override
  void initState() {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getUserInfoFirebase();
    getCategoryList();
    super.initState();
  }

  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });

    // FirebaseFireStoreHelper.instance.updateTokenFromFirebase();
    categoriesList = await FirebaseFireStoreHelper.instance.getCategories();
    // productModelList = await FirebaseFireStoreHelper.instance.getBestProducts();

    productModelList.shuffle();

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  TextEditingController search = TextEditingController();
  List<ProductModel> searchList = [];

  void searchProducts(String value) {
    searchList = productModelList
        .where((element) =>
        element.productName.toLowerCase().contains(value.toLowerCase()))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                // Routes.instance.push(widget: CartScreen(), context: context);
              },
              icon: Icon(Icons.shopping_cart_outlined))
        ],
      ),
      body: isLoading
          ? Center(
        child: Container(
          height: 100,
          width: 100,
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        ),
      )
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TopTitles(title: "Munch Kitchen", subtitle: ""),
                  TextFormField(
                    controller: search,
                    onChanged: (String value) {
                      searchProducts(value);
                    },
                    decoration: InputDecoration(
                      hintText: "Search for your desired dessert",
                    ),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  const Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            //Categories Card Box
            categoriesList.isEmpty
                ? Center(
              child: Text("Categories is empty"),
            )
                : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categoriesList
                    .map(
                      (e) => Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Routes.instance.push(
                            widget:
                            CategoryView(categoryModel: e),
                            context: context);
                      },
                      child: Card(
                        color: Colors.white,
                        elevation: 3.0,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(20.0),
                        ),
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.network(e.categoryImage),
                        ),
                      ),
                    ),
                  ),
                )
                    .toList(),
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            !isSearched()
                ? Padding(
              padding: EdgeInsets.only(top: 10.0, left: 10),
              child: Text(
                "Munch Kithchen's Products",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
                : SizedBox.fromSize(),

            SizedBox(
              height: 12.0,
            ),

            search.text.isNotEmpty && searchList.isEmpty
                ? Center(
              child: Text("No dessert found :("),
            )
                : searchList.isNotEmpty
                ? Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                  padding: EdgeInsets.only(bottom: 50),
                  shrinkWrap: true,
                  primary: false,
                  itemCount: searchList.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 0.6,
                      crossAxisCount: 2),
                  itemBuilder: (ctx, index) {
                    ProductModel singleProduct =
                    searchList[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.pink.withOpacity(0.3),
                        borderRadius:
                        BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 12.0,
                          ),
                          Image.network(
                            singleProduct.productImage,
                            height: 100.0,
                            width: 100.0,
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          Text(
                            singleProduct.productName,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                              "Price: \RM${singleProduct.productPrice}"),
                          SizedBox(
                            height: 30.0,
                          ),
                          SizedBox(
                            height: 45,
                            width: 140,
                            child: OutlinedButton(
                              onPressed: () {
                                Routes.instance.push(
                                    widget: ProductDetails(
                                        singleProduct:
                                        singleProduct),
                                    context: context);
                              },
                              child: Text(
                                "Buy",
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            )
                : productModelList.isEmpty
                ? Center(
              child: Text("Product is empty :("),
            )
                : Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                  padding: EdgeInsets.only(bottom: 50),
                  shrinkWrap: true,
                  primary: false,
                  itemCount: productModelList.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 0.6,
                      crossAxisCount: 2),
                  itemBuilder: (ctx, index) {
                    ProductModel singleProduct =
                    productModelList[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.pink.withOpacity(0.3),
                        borderRadius:
                        BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 12.0,
                          ),
                          Image.network(
                            singleProduct.productImage,
                            height: 100.0,
                            width: 100.0,
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          Text(
                            singleProduct.productName,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                              "Price: \R${singleProduct.productPrice}"),
                          SizedBox(
                            height: 30.0,
                          ),
                          SizedBox(
                            height: 45,
                            width: 140,
                            child: OutlinedButton(
                              onPressed: () {
                                Routes.instance.push(
                                    widget: ProductDetails(
                                        singleProduct:
                                        singleProduct),
                                    context: context);
                              },
                              child: Text(
                                "Buy",
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            const SizedBox(
              height: 12.0,
            ),
          ],
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
