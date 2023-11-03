import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmartly/constants/constants.dart';
import 'package:shopsmartly/firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import 'package:shopsmartly/widgets/primary_button/primary_button.dart';

import '../../provider/app_provider.dart';

class PaymentMethod extends StatefulWidget {
  //final ProductModel singleProduct;

  const PaymentMethod({super.key});

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  int groupValue = 1;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.pop(context);
            },
        ),
        backgroundColor: Colors.transparent,
        centerTitle: false,
        title: Text(
          "Payment Method",
          style: TextStyle(color: kTextColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(
              height: 36.0,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: Theme.of(context).primaryColor, width: 2.0),
              ),
              height: 80,
              width: double.infinity,
              child: Row(
                children: [
                  Radio(
                    value: 1,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                  ),
                  Text(
                    "Cash on Delivery",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 80.0,
                  ),
                  Icon(
                    Icons.money,
                    size: 40,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: Theme.of(context).primaryColor, width: 2.0),
              ),
              height: 80,
              width: double.infinity,
              child: Row(
                children: [
                  Radio(
                    value: 2,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                  ),
                  Text(
                    "Credit Card Payment",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 50.0,
                  ),
                  Icon(Icons.payment, size: 40,),
                ],
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            PrimaryButton(
              title: "Buy Now",
              onPressed: () async {
                // appProvider.clearBuyProduct();
                // appProvider.addBuyProduct(widget.singleProduct);
                //
                //
                // if (groupValue == 1) {
                //   bool value = await FirebaseFireStoreHelper.instance
                //       .uploadOrderedProductFirebase(
                //       appProvider.getBuyProductList,
                //       context,
                //       "Cash on Delivery");
                //
                //   appProvider.clearBuyProduct();
                //
                //   if (value) {
                //     Future.delayed(Duration(seconds: 2), () {
                //       Routes.instance
                //           .push(widget: CustomBottomBar(), context: context);
                //     });
                //   }
                // } else {
                //   int value = double.parse(
                //       appProvider.totalPriceBuyProductList().toString())
                //       .round()
                //       .toInt();
                //   String totalPrice = (value * 100).toString();
                //
                //   await StripeHelper.instance
                //       .makePayment(totalPrice.toString(), context);
                // }
              },
            ),
          ],
        ),
      ),
    );
  }
}
