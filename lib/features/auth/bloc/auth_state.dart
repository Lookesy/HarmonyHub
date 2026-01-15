import 'package:equatable/equatable.dart';

// Абстрактный базовый класс для всех состояний
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

// Начальное состояние, когда ничего еще не произошло
class AuthInitial extends AuthState {}

// Состояние загрузки, когда мы ждем ответа от Firebase
class AuthLoading extends AuthState {}

// Состояние успешной аутентификации. Пользователь вошел в систему
class AuthSuccess extends AuthState {}

// Состояние ошибки. Содержит сообщение об ошибке для пользователя
class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object> get props => [message];
}