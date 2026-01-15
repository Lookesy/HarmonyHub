import 'package:flutter/material.dart';
import 'package:harmonyhubhest/features/auth/view/login_page.dart';
import 'package:harmonyhubhest/features/auth/view/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // Изначально, показываем страницу входа
  bool showLoginPage = true;

  // Метод для переключения между страницами входа и регистрации
  void toggleScreens() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      // Передаем метод для переключения в LoginPage
      return LoginPage(showRegisterPage: toggleScreens);
    } else {
      // Передаем тот же метод в RegisterPage
      return RegisterPage(showLoginPage: toggleScreens);
    }
  }
}