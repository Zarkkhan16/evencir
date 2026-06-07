import 'package:equatable/equatable.dart';
import 'package:evencir_app/features/mood/domain/entities/mood_type.dart';

class MoodEntry extends Equatable {
  const MoodEntry({
    required this.mood,
    required this.submittedAt,
  });

  final MoodType mood;
  final DateTime submittedAt;

  @override
  List<Object?> get props => [mood, submittedAt];
}
