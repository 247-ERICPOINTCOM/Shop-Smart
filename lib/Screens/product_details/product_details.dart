import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmartly/Screens/cart/cart.dart';
import 'package:shopsmartly/Screens/product/customer_reviews.dart';
import 'package:shopsmartly/provider/app_provider.dart';
import '../../Object_Clasess/product_model.dart';
import '../../constants/constants.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel singleProduct;

  const ProductDetails({super.key, required this.singleProduct});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.singleProduct.productImage,
                height: 300,
                width: 400,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.singleProduct.productName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => reviews()),
                      );
                    },
                    child: Text(
                      "Reviews",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color:
                            kPrimaryLightColor, // You can set the color you prefer
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                '\$${widget.singleProduct.productPrice.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              //Text(widget.singleProduct.description), Will see first
              SizedBox(
                height: 12.0,
              ),

              DropdownButtonFormField<String>(
                hint: Text(
                  'Size',
                ),
                isExpanded: true,
                onChanged: (value) {
                  setState(() {});
                },
                items: <String>['Small', 'Medium', 'Large', 'X-Large']
                    .map((String size) {
                  return DropdownMenuItem<String>(
                    value: size,
                    child: Text(size),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 25.0,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 60,
                    width: 300,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60),
                        ),
                        backgroundColor: kPrimaryColor,
                      ),
                      onPressed: () {
                        ProductModel productModel =
                        widget.singleProduct.copyWith(productQuantity: quantity);
                        appProvider.addCartProduct(productModel);
                        showMessage("Added to Bag");
                      },
                      child: Text(
                        "Add to Bag",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: kTextColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                ],
              ),
              SizedBox(
                height: 50.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
