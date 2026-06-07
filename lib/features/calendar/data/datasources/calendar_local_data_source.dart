import 'package:evencir_app/features/calendar/data/datasources/calendar_data_source.dart';
import 'package:evencir_app/features/calendar/data/models/calendar_overview_model.dart';

class CalendarLocalDataSource implements CalendarDataSource {
  @override
  Future<CalendarOverviewModel> getMarkedDates({
    required int year,
    required int month,
  }) async {
    if (year == 2024 && month == 9) {
      return CalendarOverviewModel(
        markedDates: [
          DateTime(2024, 9, 5),
          DateTime(2024, 9, 12),
          DateTime(2024, 9, 18),
          DateTime(2024, 9, 22),
        ],
      );
    }

    return const CalendarOverviewModel(markedDates: []);
  }
}
