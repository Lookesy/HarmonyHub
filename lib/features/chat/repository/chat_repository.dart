import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:harmonyhubhest/messenger/message.dart';

/// Репозиторий для управления сообщениями в чате.
class ChatRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  ChatRepository({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  /// Возвращает поток сообщений для чата с указанным пользователем.
  Stream<List<MessageModel>> getMessages(String receiverId) {
    final String currentUserId = _firebaseAuth.currentUser!.uid;

    // Создаем уникальный ID чата из ID двух пользователей
    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => MessageModel.fromMap(doc.data()))
          .toList();
    });
  }

  /// Отправляет сообщение указанному пользователю.
  Future<void> sendMessage(String receiverId, String message) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    MessageModel newMessage = MessageModel(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverId: receiverId,
      message: message,
      timestamp: timestamp,
      receiverEmail: currentUserEmail,
    );

    // Создаем ID чата
    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    // Добавляем сообщение в подколлекцию
    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }
}
