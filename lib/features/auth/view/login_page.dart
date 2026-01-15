import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harmonyhubhest/features/auth/bloc/auth_bloc.dart';
import 'package:harmonyhubhest/features/auth/bloc/auth_event.dart';
import 'package:harmonyhubhest/features/auth/bloc/auth_state.dart';
import 'package:harmonyhubhest/home_page.dart'; // Убедитесь, что этот импорт правильный
import 'package:harmonyhubhest/style.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({super.key, required this.showRegisterPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // BlocConsumer - мощный виджет. Он объединяет 'listener' и 'builder'.
    return BlocConsumer<AuthBloc, AuthState>(
      // 1. 'listener' - для действий, которые нужно выполнить один раз:
      // навигация, показ SnackBar и т.д. Он не перестраивает UI.
      listener: (context, state) {
        if (state is AuthSuccess) {
          // Если аутентификация прошла успешно, переходим на главный экран.
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        } else if (state is AuthFailure) {
          // Если произошла ошибка, показываем SnackBar с сообщением.
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      // 2. 'builder' - для перестройки UI в ответ на изменение состояния.
      builder: (context, state) {
        // Если идет загрузка, показываем индикатор прогресса.
        if (state is AuthLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        // В любом другом случае (Initial, Failure) показываем наш UI входа.
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ... (весь ваш остальной UI: поля ввода, текст и т.д.)
                  Text(
                    'С возвращением!',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      style: TextStyle(
                        color: Colors.black
                      ),
                      controller: _emailController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Email',
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      style: TextStyle(
                          color: Colors.black
                      ),
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Пароль',
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: () {
                      // 3. Отправляем событие в BLoC при нажатии на кнопку.
                      // Мы больше не вызываем Firebase напрямую!
                      context.read<AuthBloc>().add(
                        AuthLoginRequested(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                        ),
                      );
                    },
                    child: Text('Продолжить', style: interFS15),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Впервые у нас?', style: interFS15),
                      GestureDetector(
                        onTap: widget.showRegisterPage,
                        child: Text(' Зарегистрироваться', style: interFS15),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}