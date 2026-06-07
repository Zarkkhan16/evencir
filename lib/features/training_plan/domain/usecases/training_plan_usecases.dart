import 'package:evencir_app/core/usecases/usecase.dart';
import 'package:evencir_app/features/training_plan/domain/entities/training_plan.dart';
import 'package:evencir_app/features/training_plan/domain/repositories/training_plan_repository.dart';

class GetTrainingPlan implements UseCase<TrainingPlan, NoParams> {
  GetTrainingPlan(this._repository);

  final TrainingPlanRepository _repository;

  @override
  Future<TrainingPlan> call(NoParams params) {
    return _repository.getTrainingPlan();
  }
}

class SaveTrainingPlan implements UseCase<void, TrainingPlan> {
  SaveTrainingPlan(this._repository);

  final TrainingPlanRepository _repository;

  @override
  Future<void> call(TrainingPlan params) {
    return _repository.saveTrainingPlan(params);
  }
}
