import 'package:flutter/material.dart';
import 'package:shopsmartly/Object_Clasess/category_model.dart';
import 'package:shopsmartly/Object_Clasess/product_model.dart';
import '../../constants/routes.dart';
import '../../firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import '../product_details/product_details.dart';

class CategoryView extends StatefulWidget {
  final CategoryModel categoryModel;

  const CategoryView({super.key, required this.categoryModel});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<ProductModel> productModelList = [];

  bool isLoading = false;

  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });

    productModelList = await FirebaseFireStoreHelper.instance
        .getCategoryViewProduct(widget.categoryModel.categoryID);
    productModelList.shuffle();

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getCategoryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            SizedBox(
              height: kToolbarHeight * 1,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  BackButton(),
                  Text(
                    widget.categoryModel.categoryName,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            productModelList.isEmpty
                ? Center(
              child: Text("Product is empty :("),
            )
                : Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                  padding: EdgeInsets.zero,
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
                        borderRadius: BorderRadius.circular(8.0),
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
                          Text("Price: \R${singleProduct.productPrice}"),
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
}
