import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:harmonyhubhest/features/chat/repository/chat_repository.dart';
import 'package:harmonyhubhest/messenger/message.dart'; // Убедитесь, что это MessageModel
import '../../../data/repositories/storage_repository.dart';
import '../../profile/bloc/profile_event.dart';
import 'chat_event.dart';
import 'chat_state.dart';


class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository _chatRepository;
  final StorageRepository _storageRepository;
  StreamSubscription<List<MessageModel>>? _messagesSubscription;

  ChatBloc({
    required ChatRepository chatRepository,
    required StorageRepository storageRepository,
  })  : _chatRepository = chatRepository,
        _storageRepository = storageRepository,
        super(ChatInitial()) {
    on<ChatSubscriptionRequested>(_onSubscriptionRequested);
    on<ChatMessagesReceived>(_onMessagesReceived);
    on<ChatMessageSent>(_onMessageSent);
  }

  Future<void> _onSubscriptionRequested(
      ChatSubscriptionRequested event,
      Emitter<ChatState> emit,
      ) async {
    emit(ChatInitial()); // Сбрасываем состояние на начальное
    _messagesSubscription?.cancel();

    try {
      // 1. Асинхронно загружаем URL аватара
      final avatarUrl = await _storageRepository.getUserAvatarUrl(event.receiverEmail);

      // 2. Сразу же показываем состояние с аватаром (но пока без сообщений)
      // Это позволит UI быстро отобразить аватар в AppBar
      emit(ChatLoadSuccess([], receiverAvatarUrl: avatarUrl));

      // 3. Подписываемся на поток сообщений
      _messagesSubscription = _chatRepository.getMessages(event.receiverId).listen(
            (messages) {
          add(ChatMessagesReceived(messages));
        },
        onError: (error) {
          emit(ChatLoadFailure(error.toString()));
        },
      );
    } catch (e) {
      emit(ChatLoadFailure(e.toString()));
    }
  }

  void _onMessagesReceived(ChatMessagesReceived event, Emitter<ChatState> emit) {
    // Когда приходят новые сообщения, обновляем состояние, сохраняя аватар
    if (state is ChatLoadSuccess) {
      final currentState = state as ChatLoadSuccess;
      emit(currentState.copyWith(messages: event.messages));
    } else {
      // Если по какой-то причине состояние было не ChatLoadSuccess,
      // создаем его с нуля (аватар будет null)
      emit(ChatLoadSuccess(event.messages));
    }
  }

  Future<void> _onMessageSent(ChatMessageSent event, Emitter<ChatState> emit) async {
    try {
      await _chatRepository.sendMessage(event.receiverId, event.message);
    } catch (e) {
      print("Ошибка отправки сообщения: $e");
    }
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}