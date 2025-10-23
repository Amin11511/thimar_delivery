class ShowOrderModel {
  final String? orderNumber;
  final String? orderDate;
  final String? orderStatus;
  final double? orderPrice;
  final List<dynamic>? products;
  final dynamic ordersCubit;
  final String? userImage;
  final String? userName;
  final String? userLocation;

  ShowOrderModel({
    this.orderNumber,
    this.orderDate,
    this.orderStatus,
    this.orderPrice,
    this.products,
    this.ordersCubit,
    this.userImage,
    this.userName,
    this.userLocation,
  });
}