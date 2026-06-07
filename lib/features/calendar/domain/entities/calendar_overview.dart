import 'package:equatable/equatable.dart';

class CalendarOverview extends Equatable {
  const CalendarOverview({
    required this.markedDates,
  });

  final List<DateTime> markedDates;

  @override
  List<Object?> get props => [markedDates];
}
