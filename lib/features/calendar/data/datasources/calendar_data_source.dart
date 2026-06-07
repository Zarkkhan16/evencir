import 'package:evencir_app/features/calendar/data/models/calendar_overview_model.dart';

abstract interface class CalendarDataSource {
  Future<CalendarOverviewModel> getMarkedDates({
    required int year,
    required int month,
  });
}
