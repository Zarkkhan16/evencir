import 'package:evencir_app/core/usecases/usecase.dart';
import 'package:evencir_app/features/calendar/domain/entities/calendar_overview.dart';
import 'package:evencir_app/features/calendar/domain/repositories/calendar_repository.dart';

class GetMarkedDatesParams {
  const GetMarkedDatesParams({required this.year, required this.month});

  final int year;
  final int month;
}

class GetMarkedDates
    implements UseCase<CalendarOverview, GetMarkedDatesParams> {
  GetMarkedDates(this._repository);

  final CalendarRepository _repository;

  @override
  Future<CalendarOverview> call(GetMarkedDatesParams params) {
    return _repository.getMarkedDates(
      year: params.year,
      month: params.month,
    );
  }
}
