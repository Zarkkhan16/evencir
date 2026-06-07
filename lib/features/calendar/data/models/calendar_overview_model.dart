import 'package:evencir_app/features/calendar/domain/entities/calendar_overview.dart';

class CalendarOverviewModel {
  const CalendarOverviewModel({required this.markedDates});

  factory CalendarOverviewModel.fromJson(Map<String, dynamic> json) {
    final dates = (json['marked_dates'] as List<dynamic>)
        .map((item) => DateTime.parse(item as String))
        .toList();
    return CalendarOverviewModel(markedDates: dates);
  }

  final List<DateTime> markedDates;

  Map<String, dynamic> toJson() => {
    'marked_dates': markedDates.map((date) => date.toIso8601String()).toList(),
  };

  CalendarOverview toEntity() => CalendarOverview(markedDates: markedDates);
}
