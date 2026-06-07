import 'package:equatable/equatable.dart';
import 'package:evencir_app/features/training_plan/domain/entities/training_plan.dart';

enum TrainingPlanStatus { initial, loading, success, saving, saved, failure }

class TrainingPlanState extends Equatable {
  const TrainingPlanState({
    this.status = TrainingPlanStatus.initial,
    this.plan,
    this.errorMessage,
  });

  final TrainingPlanStatus status;
  final TrainingPlan? plan;
  final String? errorMessage;

  TrainingPlanState copyWith({
    TrainingPlanStatus? status,
    TrainingPlan? plan,
    String? errorMessage,
  }) {
    return TrainingPlanState(
      status: status ?? this.status,
      plan: plan ?? this.plan,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, plan, errorMessage];
}
