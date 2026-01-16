import 'package:bloc/bloc.dart';
import 'package:harmonyhubhest/features/profile/bloc/profile_event.dart';
import 'package:harmonyhubhest/features/profile/bloc/profile_state.dart';
import 'package:harmonyhubhest/features/profile/repository/profile_repository.dart';
import 'package:harmonyhubhest/features/users/user_model.dart';
import 'package:meta/meta.dart';

import '../repository/profile_repository.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final UserProfileRepository _userProfileRepository;

  UserProfileBloc({required UserProfileRepository userProfileRepository})
      : _userProfileRepository = userProfileRepository,
        super(UserProfileInitial()) {
    on<UserProfileFetchRequested>(_onUserProfileFetchRequested);
    on<UserProfileAvatarUpdateRequested>(_onUserProfileAvatarUpdateRequested);
  }

  // Обработчик события загрузки данных профиля
  Future<void> _onUserProfileFetchRequested(
      UserProfileFetchRequested event,
      Emitter<UserProfileState> emit,
      ) async {
    emit(UserProfileLoadInProgress());
    try {
      // Одновременно запрашиваем и профиль, и URL аватара
      final userProfile = await _userProfileRepository.fetchCurrentUserProfile();
      final avatarUrl = await _userProfileRepository.getAvatarUrl();

      emit(UserProfileLoadSuccess(user: userProfile, avatarUrl: avatarUrl));
    } catch (e) {
      emit(UserProfileLoadFailure(e.toString()));
    }
  }

  // Обработчик события обновления аватара
  Future<void> _onUserProfileAvatarUpdateRequested(
      UserProfileAvatarUpdateRequested event,
      Emitter<UserProfileState> emit,
      ) async {
    // Убедимся, что у нас уже есть загруженные данные пользователя
    final currentState = state;
    if (currentState is UserProfileLoadSuccess) {
      try {
        // Вызываем метод репозитория для загрузки нового аватара
        final newAvatarUrl = await _userProfileRepository.uploadNewAvatar();

        // Выдаем новое успешное состояние со старыми данными пользователя,
        // но новым URL аватара
        emit(UserProfileLoadSuccess(user: currentState.user, avatarUrl: newAvatarUrl));

      } catch (e) {
        // Если произошла ошибка именно при обновлении - выдаем специальное состояние
        emit(UserProfileAvatarUpdateFailure(e.toString()));
        // А затем возвращаем UI в стабильное состояние с последними успешными данными
        emit(currentState);
      }
    }
    // Если BLoC находится в другом состоянии (например, в процессе загрузки),
    // мы просто игнорируем запрос на обновление аватара, чтобы избежать конфликтов.
  }
}