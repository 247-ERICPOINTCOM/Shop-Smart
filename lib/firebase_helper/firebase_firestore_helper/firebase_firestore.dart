import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopsmartly/Object_Clasess/Stores.dart';
import 'package:shopsmartly/Object_Clasess/category_model.dart';
import 'package:shopsmartly/Object_Clasess/product_model.dart';
import 'package:shopsmartly/Object_Clasess/user_model.dart';
import 'package:shopsmartly/constants/constants.dart';

class FirebaseFireStoreHelper {
  static FirebaseFireStoreHelper instance = FirebaseFireStoreHelper();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  ///User Stuff///
  Future<UserModel> getUserInformation() async {
    DocumentSnapshot<Map<String, dynamic>> querySnapshot =
        await _firebaseFirestore
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();

    return UserModel.fromJson(querySnapshot.data()!);
  }

  ///Stores///
  Future<List<StoresModel>> getStores() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await _firebaseFirestore.collection("stores").get();

      List<StoresModel> storesList = querySnapshot.docs
          .map((e) => StoresModel.fromJson(e.data()))
          .toList();

      return storesList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getStoresViewProduct(String id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await _firebaseFirestore
          .collection("stores")
          .doc(id)
          .collection("products")
          .get();

      List<ProductModel> productModelList = querySnapshot.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();

      return productModelList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  ///Categories///
  Future<List<CategoryModel>> getCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection("categories").get();

      List<CategoryModel> categoriesList = querySnapshot.docs
          .map((e) => CategoryModel.fromJson(e.data()))
          .toList();

      return categoriesList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getCategoryViewProduct(String id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
              .collection("categories")
              .doc(id)
              .collection("products")
              .get();

      List<ProductModel> productModelList = querySnapshot.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();

      return productModelList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  ///uploading user's order to firebase
  // Future<bool> uploadOrderedProductFirebase(
  //     List<ProductModel> list, BuildContext context, String payment) async {
  //   try {
  //     showLoaderDialog(context);
  //     double totalPrice = 0.0;
  //     for (var element in list) {
  //       totalPrice += element.price * element.quantity!;
  //     }
  //     DocumentReference documentReference = _firebaseFirestore
  //         .collection("usersOrders")
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .collection("orders")
  //         .doc();
  //     DocumentReference owner =
  //     _firebaseFirestore.collection("orders").doc(documentReference.id);
  //     String uid = FirebaseAuth.instance.currentUser!.uid;
  //     String? email = FirebaseAuth.instance.currentUser!.email;
  //
  //     owner.set({
  //       "products": list.map((e) => e.toJson()),
  //       "status": "Pending",
  //       "totalPrice": totalPrice,
  //       "payment": payment,
  //       "userId": uid,
  //       "orderId": owner.id,
  //       "email": email,
  //     });
  //
  //     documentReference.set({
  //       "products": list.map((e) => e.toJson()),
  //       "status": "Pending",
  //       "totalPrice": totalPrice,
  //       "payment": payment,
  //       "userId": uid,
  //       "orderId": documentReference.id,
  //       "email": email,
  //     });
  //
  //
  //     Routes.instance.push(widget: OrderConfirmationPage(), context: context);
  //     Navigator.of(context, rootNavigator: true).pop();
  //     //showMessage("Successfully Ordered");
  //
  //     return true;
  //   } catch (e) {
  //     Routes.instance.push(widget: OrderFailedPage(), context: context);
  //     Navigator.of(context, rootNavigator: true).pop();
  //     return false;
  //   }
  // }

  ///Get User Order///
  // Future<List<OrderModel>> getUserOrder() async {
  //   try {
  //     QuerySnapshot<Map<String, dynamic>> querySnapshot =
  //         await _firebaseFirestore
  //             .collection("usersOrders")
  //             .doc(FirebaseAuth.instance.currentUser!.uid)
  //             .collection("orders")
  //             .get();
  //
  //     List<OrderModel> orderList = querySnapshot.docs
  //         .map((element) => OrderModel.fromJson(element.data()))
  //         .toList();
  //     return orderList;
  //   } catch (e) {
  //     showMessage(e.toString());
  //     return [];
  //   }
  // }
  //
  // void updateTokenFromFirebase() async {
  //   String? token = await FirebaseMessaging.instance.getToken();
  //
  //   if (token != null) {
  //     await _firebaseFirestore
  //         .collection("users")
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .update({
  //       "notificationToken": token,
  //     });
  //   }
  // }
  //
  // Future<void> updateOrder(OrderModel orderModel, String status) async {
  //   await _firebaseFirestore
  //       .collection("usersOrders")
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .collection("orders")
  //       .doc(orderModel.orderId)
  //       .update({
  //     "status": status,
  //   });
  //   await _firebaseFirestore
  //       .collection("orders")
  //       .doc(orderModel.orderId)
  //       .update({
  //     "status": status,
  //   });
  // }
}
