import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harmonyhubhest/data/repositories/storage_repository.dart';
import 'package:harmonyhubhest/features/chat/bloc/chat_bloc.dart';
import 'package:harmonyhubhest/features/chat/repository/chat_repository.dart';
import 'package:harmonyhubhest/messenger/chat_bubble.dart';
import 'package:harmonyhubhest/messenger/message.dart';
import '../bloc/chat_event.dart';
import '../bloc/chat_state.dart';

class ChatPage extends StatelessWidget {
  final String receiverUserName;
  final String receiverUserEmail;
  final String receiverUserID;

  const ChatPage({super.key, required this.receiverUserEmail, required this.receiverUserID, required this.receiverUserName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(
        chatRepository: ChatRepository(),
        storageRepository: StorageRepository(),
      )..add(ChatSubscriptionRequested(
        receiverId: receiverUserID,
        receiverEmail: receiverUserEmail,
      )),
      child: ChatView(receiverUserEmail: receiverUserEmail, receiverUserID: receiverUserID),
    );
  }
}

class ChatView extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;
  const ChatView({super.key, required this.receiverUserEmail, required this.receiverUserID});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      context.read<ChatBloc>().add(ChatMessageSent(
        message: _messageController.text,
        receiverId: widget.receiverUserID,
      ));
      _messageController.clear();
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients && _scrollController.position.hasContentDimensions) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverUserEmail, overflow: TextOverflow.ellipsis),
        actions: [
          // AppBar теперь использует BlocBuilder для отображения аватара
          BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              Widget avatarWidget = const CircleAvatar(radius: 24);
              if (state is ChatLoadSuccess) {
                if (state.receiverAvatarUrl != null && state.receiverAvatarUrl!.isNotEmpty) {
                  avatarWidget = CircleAvatar(radius: 24, backgroundImage: NetworkImage(state.receiverAvatarUrl!));
                }
              }
              // Пока состояние ChatInitial, можно показать пустой CircleAvatar или загрузчик
              else if (state is ChatInitial) {
                avatarWidget = const CircleAvatar(radius: 24, child: CircularProgressIndicator());
              }

              return Padding(
                padding: const EdgeInsets.all(3.0),
                child: avatarWidget,
              );
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade800, Colors.blue.shade400],
          ),
        ),
        child: Column(
          children: [
            Expanded(child: _buildMessageList()),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageList() {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        if (state is ChatLoadSuccess) {
          if (state.messages.isNotEmpty) {
            _scrollToBottom();
          }
          return ListView.builder(
            controller: _scrollController,
            itemCount: state.messages.length,
            itemBuilder: (context, index) {
              return _buildMessageItem(state.messages[index]);
            },
          );
        } else if (state is ChatLoadFailure) {
          return Center(child: Text('Ошибка: ${state.error}'));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildMessageItem(MessageModel message) {
    var alignment = (message.senderId == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: (message.senderId == _firebaseAuth.currentUser!.uid)
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Text(message.senderEmail, style: GoogleFonts.inter(textStyle: const TextStyle(color: Colors.white, fontSize: 12))),
            const SizedBox(height: 5),
            ChatBubble(message: message.message),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                hintText: 'Введите сообщение...',
                hintStyle: TextStyle(color: Colors.white70),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
              ),
              style: const TextStyle(color: Colors.white),
              obscureText: false,
            ),
          ),
          IconButton(
            onPressed: _sendMessage,
            icon: const Icon(Icons.send, size: 30, color: Colors.white),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}