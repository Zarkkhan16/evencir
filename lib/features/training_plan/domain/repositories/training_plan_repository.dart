import 'package:evencir_app/features/training_plan/domain/entities/training_plan.dart';

abstract interface class TrainingPlanRepository {
  Future<TrainingPlan> getTrainingPlan();
  Future<void> saveTrainingPlan(TrainingPlan plan);
}
