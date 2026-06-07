import 'package:equatable/equatable.dart';

class MetricInsight extends Equatable {
  const MetricInsight({
    required this.label,
    required this.value,
    required this.subtitle,
    this.trend,
  });

  final String label;
  final String value;
  final String subtitle;
  final String? trend;

  @override
  List<Object?> get props => [label, value, subtitle, trend];
}
