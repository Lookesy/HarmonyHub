import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harmonyhubhest/features/auth/bloc/auth_event.dart';
import 'package:harmonyhubhest/features/auth/bloc/auth_state.dart';
import 'package:harmonyhubhest/features/auth/repository/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthInitial()) { // Устанавливаем начальное состояние

    // Обработчик для события входа
    on<AuthLoginRequested>(_onLoginRequested);

    // Обработчик для события регистрации
    on<AuthSignUpRequested>(_onSignUpRequested);
  }

  // Метод, который будет вызываться при событии AuthLoginRequested
  Future<void> _onLoginRequested(
      AuthLoginRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading()); // 1. Сообщаем UI, что началась загрузка
    try {
      // 2. Вызываем метод из репозитория
      await _authRepository.logInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(AuthSuccess()); // 3. Если все хорошо, сообщаем об успехе
    } catch (e) {
      // 4. Если произошла ошибка, сообщаем об ошибке
      emit(AuthFailure(e.toString()));
    }
  }

  // Метод, который будет вызываться при событии AuthSignUpRequested
  Future<void> _onSignUpRequested(
      AuthSignUpRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());
    try {
      await _authRepository.signUp(
        email: event.email,
        password: event.password,
        username: event.username,
      );
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}