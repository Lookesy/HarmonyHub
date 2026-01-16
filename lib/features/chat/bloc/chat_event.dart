import 'package:equatable/equatable.dart';

import '../../../messenger/message.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

// Запрос на подписку на сообщения и загрузку данных собеседника
class ChatSubscriptionRequested extends ChatEvent {
  final String receiverId;
  final String receiverEmail;

  const ChatSubscriptionRequested({
    required this.receiverId,
    required this.receiverEmail,
  });

  @override
  List<Object> get props => [receiverId, receiverEmail];
}

// Событие отправки нового сообщения
class ChatMessageSent extends ChatEvent {
  final String message;
  final String receiverId;

  const ChatMessageSent({required this.message, required this.receiverId});

  @override
  List<Object> get props => [message, receiverId];
}

// Внутреннее событие, когда из потока приходят новые данные.
class ChatMessagesReceived extends ChatEvent {
  final List<MessageModel> messages;

  const ChatMessagesReceived(this.messages);

  @override
  List<Object> get props => [messages];
}