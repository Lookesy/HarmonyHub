import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
// 1. Импортируем наш новый AuthPage
import 'package:harmonyhubhest/features/auth/view/auth_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // 2. Переносим логику таймера в initState
  // Этот метод вызывается один раз при создании виджета
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), (){
      // 3. Заменяем навигацию на AuthPage
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => const AuthPage(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    // Метод build теперь отвечает только за отрисовку UI
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/splashBackground.png'), fit: BoxFit.cover),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('HarmonyHub', style: GoogleFonts.fugazOne(
                        textStyle: const TextStyle(fontSize: 35, fontWeight: FontWeight.w300)
                    )),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}