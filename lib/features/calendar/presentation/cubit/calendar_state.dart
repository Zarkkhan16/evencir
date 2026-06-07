import 'package:equatable/equatable.dart';
import 'package:evencir_app/features/home/domain/entities/home_dashboard.dart';

enum CalendarStatus { initial, loading, success, failure }

class CalendarState extends Equatable {
  CalendarState({
    this.status = CalendarStatus.initial,
    DateTime? selectedDay,
    DateTime? focusedDay,
    this.markedDates = const [],
    this.dashboard,
    this.errorMessage,
  }) : selectedDay = selectedDay ?? DateTime(2024, 12, 22),
       focusedDay = focusedDay ?? DateTime(2024, 12, 22);

  final CalendarStatus status;
  final DateTime selectedDay;
  final DateTime focusedDay;
  final List<DateTime> markedDates;
  final HomeDashboard? dashboard;
  final String? errorMessage;

  CalendarState copyWith({
    CalendarStatus? status,
    DateTime? selectedDay,
    DateTime? focusedDay,
    List<DateTime>? markedDates,
    HomeDashboard? dashboard,
    String? errorMessage,
  }) {
    return CalendarState(
      status: status ?? this.status,
      selectedDay: selectedDay ?? this.selectedDay,
      focusedDay: focusedDay ?? this.focusedDay,
      markedDates: markedDates ?? this.markedDates,
      dashboard: dashboard ?? this.dashboard,
      errorMessage: errorMessage,
    );
  }

  Set<DateTime> get markedDaysSet => markedDates.toSet();

  @override
  List<Object?> get props => [
    status,
    selectedDay,
    focusedDay,
    markedDates,
    dashboard,
    errorMessage,
  ];
}
