import 'package:cloud_firestore/cloud_firestore.dart';
class MessageModel {
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final String message;
  final Timestamp timestamp;
  final String receiverEmail;
  MessageModel({
    required this.senderId,
    required this.senderEmail,
    required this.receiverId,
    required this.timestamp,
    required this.message,
    required this.receiverEmail,
  });
  // Фабричный конструктор для создания экземпляра из Map (данные из Firestore)
  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      senderId: map['senderID'] ?? '',
      senderEmail: map['senderEmail'] ?? '',
      receiverId: map['receiverId'] ?? '',
      receiverEmail: map['receiverEmail'],
      message: map['message'] ?? '',
      timestamp: map['timestamp'] as Timestamp,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'senderID': senderId,
      'senderEmail': senderEmail,
      'receiverId': receiverId,
      'receiverEmail': receiverEmail,
      'message': message,
      'timestamp': timestamp,
    };
  }
}