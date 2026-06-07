import 'package:evencir_app/features/mood/domain/entities/mood_entry.dart';
import 'package:evencir_app/features/mood/domain/entities/mood_type.dart';

class MoodEntryModel {
  const MoodEntryModel({
    required this.mood,
    required this.submittedAt,
  });

  factory MoodEntryModel.fromJson(Map<String, dynamic> json) {
    return MoodEntryModel(
      mood: MoodType.fromApiValue(json['mood'] as String),
      submittedAt: DateTime.parse(json['submitted_at'] as String),
    );
  }

  final MoodType mood;
  final DateTime submittedAt;

  Map<String, dynamic> toJson() => {
    'mood': mood.apiValue,
    'submitted_at': submittedAt.toIso8601String(),
  };

  MoodEntry toEntity() {
    return MoodEntry(mood: mood, submittedAt: submittedAt);
  }
}
