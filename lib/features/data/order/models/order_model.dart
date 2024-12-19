import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:star_shop/features/data/order/models/product_ordered_model.dart';

class OrderModel {
  final String orderID;
  final String userId;
  final String status;
  final num totalPrice;
  final num deliveryFee;
  final List<ProductOrderedModel> productsOrdered;
  final String detailedAddress;
  final String ward;
  final String district;
  final String city;
  final String cityCode;
  final String districtCode;
  final Timestamp createdAt;

  OrderModel({
    required this.orderID,
    required this.userId,
    required this.status,
    required this.totalPrice,
    required this.productsOrdered,
    required this.deliveryFee,
    required this.detailedAddress,
    required this.ward,
    required this.district,
    required this.city,
    required this.cityCode,
    required this.districtCode,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderID': orderID,
      'userId': userId,
      'status': status,
      'totalPrice': totalPrice,
      'deliveryFee': deliveryFee,
      'productsOrdered': productsOrdered.map((map) => map.toMap()).toList(),
      'detailedAddress': detailedAddress,
      'ward': ward,
      'district': district,
      'city': city,
      'cityCode': cityCode,
      'districtCode': districtCode,
      'createdAt': createdAt,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderID: map['orderID'],
      userId: map['userId'],
      status: map['status'],
      totalPrice: map['totalPrice'],
      deliveryFee: map['deliveryFee'],
      productsOrdered: List.from(map['productsOrdered']
          .map((e) => ProductOrderedModel.fromMap(e))
          .toList()),

      detailedAddress: map['detailedAddress'],
      ward: map['ward'],
      district: map['district'],
      city: map['city'],
      cityCode: map['cityCode'],
      districtCode: map['districtCode'],
      createdAt: map['createdAt'],
    );
  }
}
