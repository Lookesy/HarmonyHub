import 'package:equatable/equatable.dart';

abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

// Событие для запроса данных профиля (имя, email, аватар)
class UserProfileFetchRequested extends UserProfileEvent {}

// Событие для запроса на смену аватара
class UserProfileAvatarUpdateRequested extends UserProfileEvent {}