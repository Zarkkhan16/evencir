import 'package:equatable/equatable.dart';

class Workout extends Equatable {
  const Workout({
    required this.title,
    required this.dateRange,
    required this.duration,
  });

  final String title;
  final String dateRange;
  final String duration;

  @override
  List<Object?> get props => [title, dateRange, duration];
}
