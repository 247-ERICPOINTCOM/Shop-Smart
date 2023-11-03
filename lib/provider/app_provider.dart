import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:shopsmartly/Object_Clasess/product_model.dart';
import 'package:shopsmartly/Object_Clasess/user_model.dart';
import 'package:shopsmartly/constants/constants.dart';
import 'package:shopsmartly/firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import 'package:shopsmartly/firebase_helper/firebase_storage_helper/firebase_storage_helper.dart';

class AppProvider with ChangeNotifier {
  /// Cart Function ///
  final List<ProductModel> _cartProductList = [];
  final List<ProductModel> _buyProductList = [];

  UserModel? _userModel;
  UserModel get getUserInformation => _userModel!;

  void addCartProduct(ProductModel productModel) {
    _cartProductList.add(productModel);
    notifyListeners();
  }

  void removeCartProduct(ProductModel productModel) {
    _cartProductList.remove(productModel);
    notifyListeners();
  }

  List<ProductModel> get getCartProviderList => _cartProductList;

  // /// Favourite ///
  // final List<ProductModel> _favouriteProductList = [];
  //
  // void addFavouriteProduct(ProductModel productModel) {
  //   _favouriteProductList.add(productModel);
  //   notifyListeners();
  // }
  //
  // void removeFavouriteProduct(ProductModel productModel) {
  //   _favouriteProductList.remove(productModel);
  //   notifyListeners();
  // }

  // List<ProductModel> get getFavouriteProductList => _favouriteProductList;

  /// User Information
  void getUserInfoFirebase() async {
    _userModel = await FirebaseFireStoreHelper.instance.getUserInformation();
    notifyListeners();
  }

  void updateUserInfoFirebase(
      BuildContext context, UserModel userModel, File? file) async {
    if (file == null) {
      showLoaderDialog(context);
      _userModel = userModel;
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_userModel!.userID)
          .set(_userModel!.toJson());
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.of(context).pop();
    } else {
      showLoaderDialog(context);

      String imageUrl =
          await FirebaseStorageHelper.instance.uploadUserImage(file);
      _userModel = userModel.copyWith(userImage: imageUrl);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_userModel!.userID)
          .set(_userModel!.toJson());
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.of(context).pop();
    }
    showMessage("Successfully updated your profile");
    notifyListeners();
  }

  /// Total Price ///

  double totalPrice() {
    double totalPrice = 0.0;
    for (var element in _cartProductList) {
      totalPrice += element.productPrice * element.productQuantity!;
    }
    return totalPrice;
  }

  double totalPriceBuyProductList() {
    double totalPrice = 0.0;
    for (var element in _buyProductList) {
      totalPrice += element.productPrice * element.productQuantity!;
    }
    return totalPrice;
  }

  void updateQuantity(ProductModel productModel, int quantity) {
    int index = _cartProductList.indexOf(productModel);
    _cartProductList[index].productQuantity = quantity;
    notifyListeners();
  }

  /// Buy Product ///

  void addBuyProduct(ProductModel model) {
    _buyProductList.add(model);
    notifyListeners();
  }

  void addBuyProductCartList() {
    _buyProductList.addAll(_cartProductList);
    notifyListeners();
  }

  void clearCart() {
    _cartProductList.clear();
    notifyListeners();
  }

  void clearBuyProduct() {
    _buyProductList.clear();
    notifyListeners();
  }

  List<ProductModel> get getBuyProductList => _buyProductList;
}
