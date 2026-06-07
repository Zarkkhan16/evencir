import 'package:evencir_app/features/home/domain/entities/hydration.dart';
import 'package:evencir_app/features/home/domain/entities/metric_insight.dart';
import 'package:evencir_app/features/home/domain/entities/workout.dart';

class WorkoutModel {
  const WorkoutModel({
    required this.title,
    required this.dateRange,
    required this.duration,
  });

  factory WorkoutModel.fromJson(Map<String, dynamic> json) {
    return WorkoutModel(
      title: json['title'] as String,
      dateRange: json['date_range'] as String,
      duration: json['duration'] as String,
    );
  }

  final String title;
  final String dateRange;
  final String duration;

  Map<String, dynamic> toJson() => {
    'title': title,
    'date_range': dateRange,
    'duration': duration,
  };

  Workout toEntity() {
    return Workout(
      title: title,
      dateRange: dateRange,
      duration: duration,
    );
  }
}

class MetricInsightModel {
  const MetricInsightModel({
    required this.label,
    required this.value,
    required this.subtitle,
    this.trend,
  });

  factory MetricInsightModel.fromJson(Map<String, dynamic> json) {
    return MetricInsightModel(
      label: json['label'] as String,
      value: json['value'] as String,
      subtitle: json['subtitle'] as String,
      trend: json['trend'] as String?,
    );
  }

  final String label;
  final String value;
  final String subtitle;
  final String? trend;

  Map<String, dynamic> toJson() => {
    'label': label,
    'value': value,
    'subtitle': subtitle,
    if (trend != null) 'trend': trend,
  };

  MetricInsight toEntity() {
    return MetricInsight(
      label: label,
      value: value,
      subtitle: subtitle,
      trend: trend,
    );
  }
}

class HydrationModel {
  const HydrationModel({required this.progress});

  factory HydrationModel.fromJson(Map<String, dynamic> json) {
    return HydrationModel(
      progress: (json['progress'] as num).toDouble(),
    );
  }

  final double progress;

  Map<String, dynamic> toJson() => {'progress': progress};

  Hydration toEntity() => Hydration(progress: progress);
}
