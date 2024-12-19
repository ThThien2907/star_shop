import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel{
  final String notificationID;
  final String title;
  final String message;
  final String userId;
  final bool isRead;
  final Timestamp createdAt;

  NotificationModel({
    required this.notificationID,
    required this.title,
    required this.message,
    required this.userId,
    required this.isRead,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      'notificationID': notificationID,
      'title': title,
      'message': message,
      'userId': userId,
      'isRead': isRead,
      'createdAt': createdAt,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic>  map) {
    return NotificationModel(
      notificationID: map['notificationID'],
      title: map['title'],
      message: map['message'],
      userId: map['userId'],
      isRead: map['isRead'],
      createdAt: map['createdAt'],
    );
  }
}