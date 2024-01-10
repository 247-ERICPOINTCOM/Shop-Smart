import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmartly/Screens/cart_screen/widgets/single_cart_item.dart';
import '../../constants/constants.dart';
import '../../provider/app_provider.dart';
import '../../widgets/primary_button/primary_button.dart';

class NewCartScreen extends StatefulWidget {
  const NewCartScreen({super.key});

  @override
  State<NewCartScreen> createState() => _NewCartScreenState();
}

class _NewCartScreenState extends State<NewCartScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 180,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Total : ",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "\R ${appProvider.totalPrice().toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 110,),
                  ElevatedButton(
                    onPressed: () {  },
                    child: const Text(
                      "Checkout",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              // PrimaryButton(
              //   title: "Checkout",
              //   onPressed: () {
              //     // appProvider.clearBuyProduct();
              //     // appProvider.addBuyProductCartList();
              //     // appProvider.clearCart();
              //     // if (appProvider.getBuyProductList.isEmpty) {
              //     //   showMessage("Cart is empty :(");
              //     // } else {
              //     //   Routes.instance
              //     //       .push(widget: CartItemCheckout(), context: context);
              //     // }
              //   },
              // ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Shopping Cart",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: appProvider.getCartProviderList.isEmpty
          ? Center(
        child: Text("Your cart is empty", style: TextStyle(fontSize: 18),),
      )
          : ListView.builder(
          itemCount: appProvider.getCartProviderList.length,
          padding: EdgeInsets.all(12),
          itemBuilder: (ctx, index) {
            return SingleCartItem(
              singleProduct: appProvider.getCartProviderList[index],
            );
          }),
    );
  }
}
