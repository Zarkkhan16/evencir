import 'package:equatable/equatable.dart';
import 'package:evencir_app/features/home/domain/entities/hydration.dart';
import 'package:evencir_app/features/home/domain/entities/metric_insight.dart';
import 'package:evencir_app/features/home/domain/entities/workout.dart';

class HomeDashboard extends Equatable {
  const HomeDashboard({
    required this.date,
    required this.workout,
    required this.calories,
    required this.weight,
    required this.hydration,
  });

  final DateTime date;
  final Workout workout;
  final MetricInsight calories;
  final MetricInsight weight;
  final Hydration hydration;

  @override
  List<Object?> get props => [date, workout, calories, weight, hydration];
}
