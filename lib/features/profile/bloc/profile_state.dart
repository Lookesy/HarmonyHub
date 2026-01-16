import '../../users/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class UserProfileState {}

// Начальное состояние
class UserProfileInitial extends UserProfileState {}

// Процесс загрузки данных профиля
class UserProfileLoadInProgress extends UserProfileState {}

// Данные профиля успешно загружены
class UserProfileLoadSuccess extends UserProfileState {
  final UserModel user;
  final String avatarUrl;

  UserProfileLoadSuccess({required this.user, required this.avatarUrl});
}

// Ошибка при загрузке данных профиля
class UserProfileLoadFailure extends UserProfileState {
  final String error;

  UserProfileLoadFailure(this.error);
}

// Ошибка, возникшая именно при обновлении аватара
// (чтобы не сбрасывать весь экран в состояние ошибки)
class UserProfileAvatarUpdateFailure extends UserProfileState {
  final String error;

  UserProfileAvatarUpdateFailure(this.error);
}