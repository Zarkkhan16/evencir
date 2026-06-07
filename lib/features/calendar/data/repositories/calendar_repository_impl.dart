import 'package:evencir_app/features/calendar/data/datasources/calendar_data_source.dart';
import 'package:evencir_app/features/calendar/domain/entities/calendar_overview.dart';
import 'package:evencir_app/features/calendar/domain/repositories/calendar_repository.dart';

class CalendarRepositoryImpl implements CalendarRepository {
  CalendarRepositoryImpl(this._dataSource);

  final CalendarDataSource _dataSource;

  @override
  Future<CalendarOverview> getMarkedDates({
    required int year,
    required int month,
  }) async {
    final model = await _dataSource.getMarkedDates(year: year, month: month);
    return model.toEntity();
  }
}
