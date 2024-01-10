import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Object_Clasess/product_model.dart';
import '../../../constants/constants.dart';
import '../../../provider/app_provider.dart';

class SingleCartItem extends StatefulWidget {
  final ProductModel singleProduct;

  const SingleCartItem({super.key, required this.singleProduct});

  @override
  State<SingleCartItem> createState() => _SingleCartItemState();
}

class _SingleCartItemState extends State<SingleCartItem> {
  int quantity = 1;
  double totalPrice = 0.0;

  @override
  void initState() {
    quantity = widget.singleProduct.productQuantity ?? 1;
    totalPrice = widget.singleProduct.productPrice *
        quantity; // Calculate the initial total price
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Container(
      margin: EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 140,
              color: Colors.pink.withOpacity(0.5),
              child: Image.network(
                widget.singleProduct.productImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              height: 140,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              child: Text(
                                widget.singleProduct.productName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                CupertinoButton(
                                  onPressed: () {
                                    if (quantity > 1) {
                                      setState(() {
                                        quantity--;
                                        totalPrice =
                                            widget.singleProduct.productPrice *
                                                quantity; // Update total price
                                      });
                                      appProvider.updateQuantity(
                                          widget.singleProduct, quantity);
                                    }
                                  },
                                  padding: EdgeInsets.zero,
                                  child: CircleAvatar(
                                    maxRadius: 13,
                                    child: Icon(Icons.remove),
                                  ),
                                ),

                                //Quantity displayed for the product to increase or decrease
                                Text(
                                  quantity.toString(),
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                CupertinoButton(
                                  onPressed: () {
                                    setState(() {
                                      quantity++;
                                      totalPrice =
                                          widget.singleProduct.productPrice *
                                              quantity; // Update total price
                                    });
                                    appProvider.updateQuantity(
                                        widget.singleProduct, quantity);
                                  },
                                  padding: EdgeInsets.zero,
                                  child: CircleAvatar(
                                    maxRadius: 13,
                                    child: Icon(Icons.add),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          "\R ${totalPrice.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          appProvider.removeCartProduct(widget.singleProduct);
                          showMessage("Removed from Bag");
                        },
                        child: CircleAvatar(
                          maxRadius: 13,
                          child: Icon(
                            Icons.delete,
                            size: 16,
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kPrimaryLightColor, width: 3),
      ),
    );
  }
}
