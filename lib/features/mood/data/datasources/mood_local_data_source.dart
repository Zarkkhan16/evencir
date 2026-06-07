import 'package:evencir_app/features/mood/data/datasources/mood_data_source.dart';
import 'package:evencir_app/features/mood/data/models/mood_entry_model.dart';
import 'package:evencir_app/features/mood/domain/entities/mood_type.dart';

class MoodLocalDataSource implements MoodDataSource {
  @override
  Future<MoodEntryModel> submitMood(MoodType mood) async {
    return MoodEntryModel(mood: mood, submittedAt: DateTime.now());
  }
}
