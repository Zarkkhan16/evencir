import 'package:evencir_app/features/training_plan/data/models/training_plan_model.dart';

abstract interface class TrainingPlanDataSource {
  Future<TrainingPlanModel> getTrainingPlan();
  Future<void> saveTrainingPlan(TrainingPlanModel plan);
}
