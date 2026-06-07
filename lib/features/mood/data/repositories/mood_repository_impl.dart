import 'package:evencir_app/features/mood/data/datasources/mood_data_source.dart';
import 'package:evencir_app/features/mood/domain/entities/mood_entry.dart';
import 'package:evencir_app/features/mood/domain/entities/mood_type.dart';
import 'package:evencir_app/features/mood/domain/repositories/mood_repository.dart';

class MoodRepositoryImpl implements MoodRepository {
  MoodRepositoryImpl(this._dataSource);

  final MoodDataSource _dataSource;

  @override
  Future<MoodEntry> submitMood(MoodType mood) async {
    final model = await _dataSource.submitMood(mood);
    return model.toEntity();
  }
}
