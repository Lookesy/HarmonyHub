import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harmonyhubhest/features/users/bloc/users_event.dart';
import 'package:harmonyhubhest/features/users/bloc/users_state.dart';
import 'package:harmonyhubhest/features/users/repository/users_repository.dart';
import '../user_model.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState>{
  final UsersRepository _usersRepository;

  UsersBloc({required UsersRepository usersRepository})
      : _usersRepository = usersRepository,
        super(UsersInitial()) { // Устанавливаем начальное состояние

    // Обработчик для события входа
    on<LoadUsers>(_onLoadUsers);
  }

  Future<void> _onLoadUsers(
      LoadUsers event,
      Emitter<UsersState> emit
      ) async {
    emit(UsersLoading());
    try{
      final List<UserModel> users = await _usersRepository.getUsers();

      emit(UsersSuccess(users));
    } catch (e){
      emit(UsersFailure(e.toString()));
    }
  }
}
