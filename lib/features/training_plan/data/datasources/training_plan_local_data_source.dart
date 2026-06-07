import 'package:evencir_app/features/training_plan/data/datasources/training_plan_data_source.dart';
import 'package:evencir_app/features/training_plan/data/models/training_plan_model.dart';

class TrainingPlanLocalDataSource implements TrainingPlanDataSource {
  TrainingPlanModel _plan = _defaultPlan;

  static const _defaultPlan = TrainingPlanModel(
    weeks: [
      WeekPlanModel(
        label: 'Week 2/8',
        range: 'December',
        sessions: [
          WorkoutSessionModel(
            day: 'Mon 8',
            title: 'Arm Blaster',
            duration: '25m - 30m',
          ),
          WorkoutSessionModel(
            day: 'Thu 11',
            title: 'Leg Day Blitz',
            duration: '25m - 30m',
          ),
        ],
      ),
      WeekPlanModel(
        label: 'Week 2',
        range: 'December 14-22',
        sessions: [],
      ),
    ],
  );

  @override
  Future<TrainingPlanModel> getTrainingPlan() async => _plan;

  @override
  Future<void> saveTrainingPlan(TrainingPlanModel plan) async {
    _plan = plan;
  }
}
