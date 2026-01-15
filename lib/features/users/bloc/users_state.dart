import 'package:equatable/equatable.dart';
import 'package:harmonyhubhest/features/users/user_model.dart';

abstract class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

//Базовое состояние, когда ничего не происходит
class UsersInitial extends UsersState{}

//Состояние загрузки
class UsersLoading extends UsersState{}

//Состояние успешного выполнения задачи
class UsersSuccess extends UsersState{
  final List<UserModel> users;

  const UsersSuccess(this.users);
}

//Состояние ошибки
class UsersFailure extends UsersState {
  final String message;

  const UsersFailure(this.message);

  @override
  List<Object> get props => [message];
}