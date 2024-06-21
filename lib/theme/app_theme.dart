import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData get appTheme {
  final colorScheme = ColorScheme.fromSeed(seedColor: Colors.deepPurple);

  final theme = ThemeData(
    colorScheme: colorScheme,
    useMaterial3: true,
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontWeight: FontWeight.bold,
        color: colorScheme.primary,
      ),
      titleMedium: TextStyle(
        fontWeight: FontWeight.w600,
        color: colorScheme.primary,
      ),
      labelLarge: const TextStyle(fontWeight: FontWeight.bold),
      labelMedium: const TextStyle(fontWeight: FontWeight.w600),
    ),
  );

  return theme.copyWith(
    textTheme: GoogleFonts.montserratTextTheme(theme.textTheme),
  );
}
