import 'package:equatable/equatable.dart';
import '../../../messenger/message.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoadSuccess extends ChatState {
  final List<MessageModel> messages;
  final String? receiverAvatarUrl; // URL аватара собеседника

  const ChatLoadSuccess(this.messages, {this.receiverAvatarUrl});

  @override
  List<Object?> get props => [messages, receiverAvatarUrl];

  // Метод copyWith для удобного обновления состояния
  ChatLoadSuccess copyWith({
    List<MessageModel>? messages,
    String? receiverAvatarUrl,
  }) {
    return ChatLoadSuccess(
      messages ?? this.messages,
      receiverAvatarUrl: receiverAvatarUrl ?? this.receiverAvatarUrl,
    );
  }
}

class ChatLoadFailure extends ChatState {
  final String error;

  const ChatLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}