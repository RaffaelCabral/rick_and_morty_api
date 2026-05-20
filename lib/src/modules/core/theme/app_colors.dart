import 'package:flutter/material.dart';

/// Paleta inspirada no universo Rick and Morty (portal + sci-fi).
abstract final class AppColors {
  static const Color portalGreen = Color(0xFF42D9C8);
  static const Color portalGreenDark = Color(0xFF1A9E8F);
  static const Color rickGreen = Color(0xFF97CE4C);
  static const Color portalGlow = Color(0xFF5CE1E6);

  static const Color background = Color(0xFF0F1117);
  static const Color surface = Color(0xFF161B26);
  static const Color surfaceElevated = Color(0xFF1E2433);
  static const Color surfaceCard = Color(0xFF252B3D);

  static const Color textPrimary = Color(0xFFF0F2F5);
  static const Color textSecondary = Color(0xFF9CA3AF);
  static const Color textMuted = Color(0xFF6B7280);
  static const Color outlineVariant = Color(0xFF2D3548);

  static const Color alive = Color(0xFF4ADE80);
  static const Color dead = Color(0xFFF87171);
  static const Color unknown = Color(0xFF94A3B8);

  static const Color error = Color(0xFFEF4444);

  static const LinearGradient portalGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [portalGreen, portalGreenDark],
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF141820), background],
  );
}
