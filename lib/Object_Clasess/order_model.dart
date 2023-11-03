import 'product_model.dart';

class OrderModel {
  OrderModel(
      {required this.totalPrice,
      required this.orderID,
      required this.paymentType,
      required this.orderStatus,
      required this.orderedProducts,
      required this.userID});

  String paymentType;
  String orderStatus;
  String orderID;
  double totalPrice;
  List<ProductModel> orderedProducts;
  String userID;

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> productMap = json["orderedProducts"];
    return OrderModel(
      orderID: json["orderID"],
      userID: json["userID"],
      orderedProducts: productMap.map((e) => ProductModel.fromJson(e)).toList(),
      orderStatus: json["orderStatus"],
      totalPrice: json["totalPrice"],
      paymentType: json["paymentType"],
    );
  }
}
