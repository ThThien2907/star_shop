import 'package:cloud_firestore/cloud_firestore.dart';

class OrderStatusModel{
  final String title;
  final String status;
  final Timestamp createdDate;

  OrderStatusModel({required this.title, required this.status, required this.createdDate,});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'status': status,
      'createdDate': createdDate,
    };
  }

  factory OrderStatusModel.fromMap(Map<String, dynamic> map) {
    return OrderStatusModel(
      title: map['title'],
      status: map['status'],
      createdDate: map['createdDate'],
    );
  }
}