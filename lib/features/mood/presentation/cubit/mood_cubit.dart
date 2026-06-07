import 'package:evencir_app/core/error/exceptions.dart';
import 'package:evencir_app/features/mood/domain/entities/mood_type.dart';
import 'package:evencir_app/features/mood/domain/usecases/submit_mood.dart';
import 'package:evencir_app/features/mood/presentation/cubit/mood_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoodCubit extends Cubit<MoodState> {
  MoodCubit({required SubmitMood submitMood})
    : _submitMood = submitMood,
      super(const MoodState());

  final SubmitMood _submitMood;

  void selectMood(MoodType mood) {
    emit(state.copyWith(selectedMood: mood, errorMessage: null));
  }

  Future<void> submit() async {
    emit(state.copyWith(status: MoodStatus.submitting, errorMessage: null));
    try {
      final entry = await _submitMood(state.selectedMood);
      emit(
        state.copyWith(
          status: MoodStatus.success,
          lastEntry: entry,
        ),
      );
      emit(state.copyWith(status: MoodStatus.initial));
    } on AppException catch (error) {
      emit(
        state.copyWith(
          status: MoodStatus.failure,
          errorMessage: error.message,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: MoodStatus.failure,
          errorMessage: 'Failed to save mood',
        ),
      );
    }
  }
}
