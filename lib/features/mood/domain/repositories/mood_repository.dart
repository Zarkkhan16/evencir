import 'package:evencir_app/features/mood/domain/entities/mood_entry.dart';
import 'package:evencir_app/features/mood/domain/entities/mood_type.dart';

abstract interface class MoodRepository {
  Future<MoodEntry> submitMood(MoodType mood);
}
