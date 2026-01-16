import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harmonyhubhest/features/profile/bloc/profile_bloc.dart';
import 'package:harmonyhubhest/style.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';

class PopupProfileWidget extends StatefulWidget {
  const PopupProfileWidget({Key? key}) : super(key: key);
  @override
  State<PopupProfileWidget> createState() => _PopupProfileWidgetState();
}
class _PopupProfileWidgetState extends State<PopupProfileWidget> {
  @override
  void initState() {
    super.initState();
    // При инициализации виджета отправляем событие для загрузки данных профиля
    context.read<UserProfileBloc>().add(UserProfileFetchRequested());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // ... (внешний вид контейнера остается без изменений)
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/image 5.png'),
            fit: BoxFit.cover,
            opacity: 0.8,
          ),
        ),
        child: Center(
          // Используем BlocConsumer для реакции на состояния и события BLoC
          child: BlocConsumer<UserProfileBloc, UserProfileState>(
            listener: (context, state) {
              // Показываем SnackBar, если произошла ошибка при обновлении аватара
              if (state is UserProfileAvatarUpdateFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Ошибка обновления аватара: ${state.error}'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              // --- Состояние: УСПЕШНАЯ ЗАГРУЗКА ---
              if (state is UserProfileLoadSuccess) {
                return _buildProfileView(context, state);
              }
              // --- Состояние: ЗАГРУЗКА или НАЧАЛЬНОЕ ---
              if (state is UserProfileLoadInProgress || state is UserProfileInitial) {
                return const Center(child: CircularProgressIndicator());
              }
              // --- Состояние: ОШИБКА ЗАГРУЗКИ ---
              if (state is UserProfileLoadFailure) {
                return Center(
                  child: Text(
                    'Ошибка загрузки профиля: \n${state.error}',
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                );
              }
              // --- Запасной вариант на случай непредвиденного состояния ---
              return const Center(
                child: Text(
                  'Произошла непредвиденная ошибка',
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
  // Виджет для отображения контента профиля при успешной загрузке
  Widget _buildProfileView(BuildContext context, UserProfileLoadSuccess state) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Аватар
          GestureDetector(
            onTap: () {
              // При нажатии отправляем событие для обновления аватара
              context.read<UserProfileBloc>().add(UserProfileAvatarUpdateRequested());
            },
            child: CircleAvatar(
              radius: 75,
              // Если URL аватара пуст, показываем иконку, иначе - изображение
              backgroundImage: state.avatarUrl.isNotEmpty
                  ? NetworkImage(state.avatarUrl)
                  : null,
              child: state.avatarUrl.isEmpty
                  ? const Icon(Icons.person, size: 75)
                  : null,
            ),
          ),
          const SizedBox(height: 25),
          // Email пользователя
          Text(
            state.user.email, // Берем email из состояния
            style: interFS20,
          ),
        ],
      ),
    );
  }
}