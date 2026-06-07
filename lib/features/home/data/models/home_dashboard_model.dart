import 'package:evencir_app/features/home/data/models/home_models.dart';
import 'package:evencir_app/features/home/domain/entities/home_dashboard.dart';

class HomeDashboardModel {
  const HomeDashboardModel({
    required this.date,
    required this.workout,
    required this.calories,
    required this.weight,
    required this.hydration,
  });

  factory HomeDashboardModel.fromJson(Map<String, dynamic> json) {
    return HomeDashboardModel(
      date: DateTime.parse(json['date'] as String),
      workout: WorkoutModel.fromJson(json['workout'] as Map<String, dynamic>),
      calories: MetricInsightModel.fromJson(
        json['calories'] as Map<String, dynamic>,
      ),
      weight: MetricInsightModel.fromJson(
        json['weight'] as Map<String, dynamic>,
      ),
      hydration: HydrationModel.fromJson(
        json['hydration'] as Map<String, dynamic>,
      ),
    );
  }

  final DateTime date;
  final WorkoutModel workout;
  final MetricInsightModel calories;
  final MetricInsightModel weight;
  final HydrationModel hydration;

  Map<String, dynamic> toJson() => {
    'date': date.toIso8601String(),
    'workout': workout.toJson(),
    'calories': calories.toJson(),
    'weight': weight.toJson(),
    'hydration': hydration.toJson(),
  };

  HomeDashboard toEntity() {
    return HomeDashboard(
      date: date,
      workout: workout.toEntity(),
      calories: calories.toEntity(),
      weight: weight.toEntity(),
      hydration: hydration.toEntity(),
    );
  }
}
