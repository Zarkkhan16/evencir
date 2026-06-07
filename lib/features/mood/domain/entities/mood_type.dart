import 'dart:math' as math;

import 'package:evencir_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

enum MoodType {
  calm(
    label: 'Calm',
    faceColor: Color(0xFFF8D4C4),
    accentColor: AppColors.accentPurple,
    angle: -0.5235987755982988,
    assetPath: 'assets/images/mood/mood_calm.png',
  ),
  content(
    label: 'Content',
    faceColor: Color(0xFFFFD60A),
    accentColor: AppColors.accentYellow,
    angle: 0.7853981633974483,
    assetPath: 'assets/images/mood/mood_content.png',
  ),
  peaceful(
    label: 'Peaceful',
    faceColor: Color(0xFFE8C9A8),
    accentColor: AppColors.accentTeal,
    angle: 2.356194490192345,
    assetPath: 'assets/images/mood/mood_peaceful.png',
  ),
  happy(
    label: 'Happy',
    faceColor: Color(0xFFF4C4A8),
    accentColor: AppColors.accentOrange,
    angle: 3.926990816987241,
    assetPath: 'assets/images/mood/mood_happy.png',
  );
  

  const MoodType({
    required this.label,
    required this.faceColor,
    required this.accentColor,
    required this.angle,
    required this.assetPath,
  });

  final String label;
  final Color faceColor;
  final Color accentColor;
  final double angle;
  final String assetPath;

  String get apiValue => name;

  static MoodType fromApiValue(String value) {
    return MoodType.values.firstWhere(
      (mood) => mood.name == value,
      orElse: () => MoodType.calm,
    );
  }

  static const pickerMoods = MoodType.values;

  static MoodType fromPickerAngle(double angle) {
    var best = pickerMoods.first;
    var bestDistance = double.infinity;

    for (final mood in pickerMoods) {
      var distance = (angle - mood.angle).abs();
      if (distance > math.pi) {
        distance = 2 * math.pi - distance;
      }
      if (distance < bestDistance) {
        bestDistance = distance;
        best = mood;
      }
    }

    return best;
  }
}
