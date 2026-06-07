import 'package:evencir_app/features/mood/data/models/mood_entry_model.dart';
import 'package:evencir_app/features/mood/domain/entities/mood_type.dart';

abstract interface class MoodDataSource {
  Future<MoodEntryModel> submitMood(MoodType mood);
}
