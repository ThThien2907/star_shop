import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:star_shop/features/domain/order/entities/product_ordered_entity.dart';

class OrderEntity {
  final String orderID;
  final String userId;
  final String status;
  final num totalPrice;
  final num deliveryFee;
  final List<ProductOrderedEntity> productsOrdered;
  final String detailedAddress;
  final String ward;
  final String district;
  final String city;
  final String cityCode;
  final String districtCode;
  final Timestamp createdAt;

  OrderEntity({
    required this.orderID,
    required this.userId,
    required this.status,
    required this.totalPrice,
    required this.deliveryFee,
    required this.productsOrdered,
    required this.detailedAddress,
    required this.ward,
    required this.district,
    required this.city,
    required this.cityCode,
    required this.districtCode,
    required this.createdAt,
  });
}
