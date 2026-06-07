import 'package:equatable/equatable.dart';
import 'package:evencir_app/features/mood/domain/entities/mood_entry.dart';
import 'package:evencir_app/features/mood/domain/entities/mood_type.dart';

enum MoodStatus { initial, submitting, success, failure }

class MoodState extends Equatable {
  const MoodState({
    this.status = MoodStatus.initial,
    this.selectedMood = MoodType.calm,
    this.lastEntry,
    this.errorMessage,
  });

  final MoodStatus status;
  final MoodType selectedMood;
  final MoodEntry? lastEntry;
  final String? errorMessage;

  MoodState copyWith({
    MoodStatus? status,
    MoodType? selectedMood,
    MoodEntry? lastEntry,
    String? errorMessage,
  }) {
    return MoodState(
      status: status ?? this.status,
      selectedMood: selectedMood ?? this.selectedMood,
      lastEntry: lastEntry ?? this.lastEntry,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, selectedMood, lastEntry, errorMessage];
}
