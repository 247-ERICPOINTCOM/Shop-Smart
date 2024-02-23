import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:shopsmartly/Screens/cart_item_checkout/cart_item_checkout.dart';
import 'package:shopsmartly/Screens/cart_screen/widgets/single_cart_item.dart';
import 'package:shopsmartly/constants/routes.dart';
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
                    onPressed: () {
                      appProvider.clearBuyProduct();
                      appProvider.addBuyProductCartList();
                      appProvider.clearCart();
                      if (appProvider.getBuyProductList.isEmpty) {
                        showMessage("Please add an item");
                      } else {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: CartItemCheckout(),
                          withNavBar: false, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        );
                      }
                    },
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
