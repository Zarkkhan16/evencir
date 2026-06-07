import 'package:evencir_app/features/calendar/domain/entities/calendar_overview.dart';

abstract interface class CalendarRepository {
  Future<CalendarOverview> getMarkedDates({required int year, required int month});
}
