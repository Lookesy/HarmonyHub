import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harmonyhubhest/features/users/bloc/users_bloc.dart';
import 'package:harmonyhubhest/features/users/bloc/users_state.dart';
import 'package:harmonyhubhest/features/chat/view/chat_page.dart';

class MessMain extends StatefulWidget {
  const MessMain({super.key});
  @override
  State<MessMain> createState() => _MessMainState();
}
class _MessMainState extends State<MessMain> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: const Text(
          'Чаты',
          style: TextStyle(
            fontSize: 25
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          if (state is UsersLoading || state is UsersInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UsersSuccess) {
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];
                if (user.email != currentUser.email) {
                  return ListTile(
                    title: Text(
                      user.email,
                      style: const TextStyle(color: Colors.red),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatPage(
                            receiverUserName: user.username,
                            receiverUserID: user.uid,
                            receiverUserEmail: user.email,
                          ),
                        ),
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            );
          }
          if (state is UsersFailure) {
            return Center(
              child: Text(
                'Ошибка: ${state.message}',
                style: const TextStyle(color: Colors.white),
              ),
            );
          }
          return const Center(
            child: Text(
              'Произошла непредвиденная ошибка',
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}