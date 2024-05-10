import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'auth/login_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), (){
      Navigator.pushReplacement(context, PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
        transitionDuration: Duration(seconds: 1),
        transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child,),
      ));
    });
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/images/splashBackground.png'), fit: BoxFit.cover),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('HarmonyHub', style: GoogleFonts.fugazOne(
                    textStyle: TextStyle(fontSize: 35, fontWeight: FontWeight.w300)
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
