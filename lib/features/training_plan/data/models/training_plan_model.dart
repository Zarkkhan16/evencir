import 'package:evencir_app/features/training_plan/domain/entities/training_plan.dart';

class WorkoutSessionModel {
  const WorkoutSessionModel({
    required this.day,
    required this.title,
    required this.duration,
  });

  factory WorkoutSessionModel.fromJson(Map<String, dynamic> json) {
    return WorkoutSessionModel(
      day: json['day'] as String,
      title: json['title'] as String,
      duration: json['duration'] as String,
    );
  }

  final String day;
  final String title;
  final String duration;

  Map<String, dynamic> toJson() => {
    'day': day,
    'title': title,
    'duration': duration,
  };

  WorkoutSession toEntity() {
    return WorkoutSession(day: day, title: title, duration: duration);
  }
}

class WeekPlanModel {
  const WeekPlanModel({
    required this.label,
    required this.range,
    required this.sessions,
  });

  factory WeekPlanModel.fromJson(Map<String, dynamic> json) {
    return WeekPlanModel(
      label: json['label'] as String,
      range: json['range'] as String,
      sessions: (json['sessions'] as List<dynamic>)
          .map(
            (item) =>
                WorkoutSessionModel.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  final String label;
  final String range;
  final List<WorkoutSessionModel> sessions;

  Map<String, dynamic> toJson() => {
    'label': label,
    'range': range,
    'sessions': sessions.map((session) => session.toJson()).toList(),
  };

  WeekPlan toEntity() {
    return WeekPlan(
      label: label,
      range: range,
      sessions: sessions.map((session) => session.toEntity()).toList(),
    );
  }
}

class TrainingPlanModel {
  const TrainingPlanModel({required this.weeks});

  factory TrainingPlanModel.fromJson(Map<String, dynamic> json) {
    return TrainingPlanModel(
      weeks: (json['weeks'] as List<dynamic>)
          .map((item) => WeekPlanModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  final List<WeekPlanModel> weeks;

  Map<String, dynamic> toJson() => {
    'weeks': weeks.map((week) => week.toJson()).toList(),
  };

  TrainingPlan toEntity() {
    return TrainingPlan(weeks: weeks.map((week) => week.toEntity()).toList());
  }
}
