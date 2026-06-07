import 'package:equatable/equatable.dart';

class WorkoutSession extends Equatable {
  const WorkoutSession({
    required this.day,
    required this.title,
    required this.duration,
  });

  final String day;
  final String title;
  final String duration;

  @override
  List<Object?> get props => [day, title, duration];
}

class WeekPlan extends Equatable {
  const WeekPlan({
    required this.label,
    required this.range,
    required this.sessions,
  });

  final String label;
  final String range;
  final List<WorkoutSession> sessions;

  @override
  List<Object?> get props => [label, range, sessions];
}

class TrainingPlan extends Equatable {
  const TrainingPlan({required this.weeks});

  final List<WeekPlan> weeks;

  @override
  List<Object?> get props => [weeks];
}
