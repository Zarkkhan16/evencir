import 'package:evencir_app/core/usecases/usecase.dart';
import 'package:evencir_app/features/mood/domain/entities/mood_entry.dart';
import 'package:evencir_app/features/mood/domain/entities/mood_type.dart';
import 'package:evencir_app/features/mood/domain/repositories/mood_repository.dart';

class SubmitMood implements UseCase<MoodEntry, MoodType> {
  SubmitMood(this._repository);

  final MoodRepository _repository;

  @override
  Future<MoodEntry> call(MoodType params) {
    return _repository.submitMood(params);
  }
}
