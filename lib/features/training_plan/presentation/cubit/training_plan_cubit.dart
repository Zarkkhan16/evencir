import 'package:evencir_app/core/error/exceptions.dart';
import 'package:evencir_app/core/usecases/usecase.dart';
import 'package:evencir_app/features/training_plan/domain/entities/training_plan.dart';
import 'package:evencir_app/features/training_plan/domain/usecases/training_plan_usecases.dart';
import 'package:evencir_app/features/training_plan/presentation/cubit/training_plan_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrainingPlanCubit extends Cubit<TrainingPlanState> {
  TrainingPlanCubit({
    required GetTrainingPlan getTrainingPlan,
    required SaveTrainingPlan saveTrainingPlan,
  }) : _getTrainingPlan = getTrainingPlan,
       _saveTrainingPlan = saveTrainingPlan,
       super(const TrainingPlanState());

  final GetTrainingPlan _getTrainingPlan;
  final SaveTrainingPlan _saveTrainingPlan;

  Future<void> load() async {
    emit(state.copyWith(status: TrainingPlanStatus.loading, errorMessage: null));
    try {
      final plan = await _getTrainingPlan(const NoParams());
      emit(
        state.copyWith(status: TrainingPlanStatus.success, plan: plan),
      );
    } on AppException catch (error) {
      emit(
        state.copyWith(
          status: TrainingPlanStatus.failure,
          errorMessage: error.message,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: TrainingPlanStatus.failure,
          errorMessage: 'Failed to load training plan',
        ),
      );
    }
  }

  void moveSession({
    required int sourceWeekIndex,
    required int targetWeekIndex,
    required WorkoutSession session,
    required String targetDayLabel,
    required String targetDayNumber,
  }) {
    final plan = state.plan;
    if (plan == null) return;
    if (sourceWeekIndex >= plan.weeks.length ||
        targetWeekIndex >= plan.weeks.length) {
      return;
    }

    final targetDay = '$targetDayLabel $targetDayNumber';
    if (sourceWeekIndex == targetWeekIndex && session.day == targetDay) {
      return;
    }

    final weeks = List<WeekPlan>.from(plan.weeks);
    final sourceWeek = weeks[sourceWeekIndex];
    final sourceSessions = List<WorkoutSession>.from(sourceWeek.sessions);

    final sourceIndex = sourceSessions.indexWhere(
      (item) => item.day == session.day && item.title == session.title,
    );
    if (sourceIndex == -1) return;

    final moving = sourceSessions.removeAt(sourceIndex);
    weeks[sourceWeekIndex] = WeekPlan(
      label: sourceWeek.label,
      range: sourceWeek.range,
      sessions: sourceSessions,
    );

    final targetWeek = weeks[targetWeekIndex];
    final targetSessions = List<WorkoutSession>.from(targetWeek.sessions);
    final targetIndex = targetSessions.indexWhere((item) => item.day == targetDay);

    if (targetIndex == -1) {
      targetSessions.add(
        WorkoutSession(
          day: targetDay,
          title: moving.title,
          duration: moving.duration,
        ),
      );
    } else {
      final occupying = targetSessions[targetIndex];
      targetSessions[targetIndex] = WorkoutSession(
        day: targetDay,
        title: moving.title,
        duration: moving.duration,
      );
      if (sourceWeekIndex == targetWeekIndex) {
        targetSessions.add(
          WorkoutSession(
            day: session.day,
            title: occupying.title,
            duration: occupying.duration,
          ),
        );
      } else {
        sourceSessions.add(
          WorkoutSession(
            day: session.day,
            title: occupying.title,
            duration: occupying.duration,
          ),
        );
        weeks[sourceWeekIndex] = WeekPlan(
          label: sourceWeek.label,
          range: sourceWeek.range,
          sessions: sourceSessions,
        );
      }
    }

    weeks[targetWeekIndex] = WeekPlan(
      label: targetWeek.label,
      range: targetWeek.range,
      sessions: targetSessions,
    );

    emit(state.copyWith(plan: TrainingPlan(weeks: weeks)));
  }

  Future<void> save() async {
    final plan = state.plan;
    if (plan == null) return;

    emit(state.copyWith(status: TrainingPlanStatus.saving, errorMessage: null));
    try {
      await _saveTrainingPlan(plan);
      emit(state.copyWith(status: TrainingPlanStatus.saved));
      emit(state.copyWith(status: TrainingPlanStatus.success));
    } on AppException catch (error) {
      emit(
        state.copyWith(
          status: TrainingPlanStatus.failure,
          errorMessage: error.message,
        ),
      );
    }
  }
}
