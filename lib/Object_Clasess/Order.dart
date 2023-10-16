class Order {
  final int orderID;
  final int customerId;
  final String orderStatus;
  final String orderdate;

  //this data does not belong to this class it have own class but this only to show the data on interface
  final String driverName;
  final String carNumber;

  const Order({
    required this.orderID,
    required this.customerId,
    required this.driverName,
    required this.carNumber,
    required this.orderdate,
    required this.orderStatus

  });

  Order copy({
    int? orderID,
    int? customerId,
    String? driverName,
    String? orderdate,
    String? orderStatus,
    String? carNumber

  }) =>
      Order(
          orderID: this.orderID,
          customerId: this.customerId,
          driverName: this.driverName,
          carNumber: this.carNumber,
          orderStatus: this.orderStatus,
          orderdate: this.orderdate
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Order &&
              runtimeType == other.runtimeType &&
              orderID == other.orderID &&
              customerId == other.customerId &&
              driverName == other.driverName &&
              carNumber == other.carNumber &&
              orderdate == other.orderdate &&
              orderStatus == other.orderStatus;

  @override
  int get hashCode =>
      orderID.hashCode ^ customerId.hashCode ^ driverName.hashCode ^ carNumber
          .hashCode ^ orderdate.hashCode ^ orderStatus.hashCode;


}
