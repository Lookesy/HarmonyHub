import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Импортируем flutter_bloc
import 'package:harmonyhubhest/features/auth/bloc/auth_bloc.dart'; // Импортируем наш BLoC
import 'package:harmonyhubhest/features/auth/repository/auth_repository.dart'; // Импортируем наш репозиторий
import 'package:harmonyhubhest/features/users/bloc/users_event.dart';
import 'features/profile/bloc/profile_bloc.dart';
import 'features/profile/repository/profile_repository.dart';
import 'features/users/bloc/users_bloc.dart';
import 'features/users/repository/users_repository.dart';
import 'firebase_options.dart';
import 'splash.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

//Главный виджет с вкладками, содержащими остальные виджеты.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    // Теперь мы предоставляем два BLoC'а: AuthBloc и UsersBloc
    return MultiBlocProvider(
      providers: [
        // Провайдер для Аутентификации
        BlocProvider(
          create: (context) => AuthBloc(
            authRepository: AuthRepository(),
          ),
        ),
        // Провайдер для Списка Пользователей
        BlocProvider(
          create: (context) => UsersBloc(
            usersRepository: UsersRepository(),
          )..add(LoadUsers()), // <-- Сразу отправляем событие на загрузку!
        ),
        BlocProvider<UserProfileBloc>(
          create: (context) => UserProfileBloc(
            userProfileRepository: UserProfileRepository(),
          ), // Загрузку профиля будем запускать при открытии экрана профиля
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'HarmonyHub',
        home: SplashScreen(),
      ),
    );
  }
}
