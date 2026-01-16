import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  // Цветовая палитра "Глубокий Космос"
  static const Color primaryBackground = Color(0xFF0D1117);
  static const Color surfaceColor = Color(0xFF161B22);
  static const Color primaryAccent = Color(0xFF30B4FF);
  static const Color secondaryAccent = Color(0xFF8B94F8);
  static const Color primaryText = Color(0xFFE6EDF3);
  static const Color secondaryText = Color(0xFF8B93A0); // Для второстепенного текста

  // Градиент для фона
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [primaryBackground, surfaceColor],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Стили текста
  static final TextStyle headline1 = GoogleFonts.inter(
    color: primaryText,
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle bodyText = GoogleFonts.inter(
    color: primaryText,
    fontSize: 16,
  );

  static final TextStyle buttonText = GoogleFonts.inter(
    color: primaryText,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle hintText = GoogleFonts.inter(
    color: secondaryText,
    fontSize: 16,
  );

  static final TextStyle caption = GoogleFonts.inter(
    color: secondaryText,
    fontSize: 12,
  );
}