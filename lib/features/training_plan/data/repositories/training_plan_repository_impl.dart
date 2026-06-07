import 'package:evencir_app/features/training_plan/data/datasources/training_plan_data_source.dart';
import 'package:evencir_app/features/training_plan/data/models/training_plan_model.dart';
import 'package:evencir_app/features/training_plan/domain/entities/training_plan.dart';
import 'package:evencir_app/features/training_plan/domain/repositories/training_plan_repository.dart';

class TrainingPlanRepositoryImpl implements TrainingPlanRepository {
  TrainingPlanRepositoryImpl(this._dataSource);

  final TrainingPlanDataSource _dataSource;

  @override
  Future<TrainingPlan> getTrainingPlan() async {
    final model = await _dataSource.getTrainingPlan();
    return model.toEntity();
  }

  @override
  Future<void> saveTrainingPlan(TrainingPlan plan) async {
    final model = TrainingPlanModel(
      weeks: plan.weeks
          .map(
            (week) => WeekPlanModel(
              label: week.label,
              range: week.range,
              sessions: week.sessions
                  .map(
                    (session) => WorkoutSessionModel(
                      day: session.day,
                      title: session.title,
                      duration: session.duration,
                    ),
                  )
                  .toList(),
            ),
          )
          .toList(),
    );
    await _dataSource.saveTrainingPlan(model);
  }
}
