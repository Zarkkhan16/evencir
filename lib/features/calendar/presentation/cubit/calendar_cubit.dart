import 'package:evencir_app/core/error/exceptions.dart';
import 'package:evencir_app/features/calendar/domain/usecases/get_marked_dates.dart';
import 'package:evencir_app/features/calendar/presentation/cubit/calendar_state.dart';
import 'package:evencir_app/features/home/domain/entities/home_dashboard.dart';
import 'package:evencir_app/features/home/domain/usecases/get_home_dashboard.dart';
import 'package:evencir_app/features/home/domain/usecases/log_water.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit({
    required GetMarkedDates getMarkedDates,
    required GetHomeDashboard getHomeDashboard,
    required LogWater logWater,
  }) : _getMarkedDates = getMarkedDates,
       _getHomeDashboard = getHomeDashboard,
       _logWater = logWater,
       super(CalendarState());

  final GetMarkedDates _getMarkedDates;
  final GetHomeDashboard _getHomeDashboard;
  final LogWater _logWater;

  Future<void> load() async {
    emit(state.copyWith(status: CalendarStatus.loading, errorMessage: null));
    try {
      final overview = await _getMarkedDates(
        GetMarkedDatesParams(
          year: state.focusedDay.year,
          month: state.focusedDay.month,
        ),
      );
      final dashboard = await _getHomeDashboard(state.selectedDay);
      emit(
        state.copyWith(
          status: CalendarStatus.success,
          markedDates: overview.markedDates,
          dashboard: dashboard,
        ),
      );
    } on AppException catch (error) {
      emit(
        state.copyWith(
          status: CalendarStatus.failure,
          errorMessage: error.message,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: CalendarStatus.failure,
          errorMessage: 'Failed to load calendar',
        ),
      );
    }
  }

  Future<void> selectDay(DateTime selected, DateTime focused) async {
    emit(
      state.copyWith(
        selectedDay: selected,
        focusedDay: focused,
        status: CalendarStatus.loading,
      ),
    );
    try {
      final dashboard = await _getHomeDashboard(selected);
      emit(
        state.copyWith(
          status: CalendarStatus.success,
          dashboard: dashboard,
        ),
      );
    } on AppException catch (error) {
      emit(
        state.copyWith(
          status: CalendarStatus.failure,
          errorMessage: error.message,
        ),
      );
    }
  }

  Future<void> onPageChanged(DateTime focused) async {
    emit(state.copyWith(focusedDay: focused, status: CalendarStatus.loading));
    try {
      final overview = await _getMarkedDates(
        GetMarkedDatesParams(year: focused.year, month: focused.month),
      );
      emit(
        state.copyWith(
          status: CalendarStatus.success,
          markedDates: overview.markedDates,
        ),
      );
    } on AppException catch (error) {
      emit(
        state.copyWith(
          status: CalendarStatus.failure,
          errorMessage: error.message,
        ),
      );
    }
  }

  Future<void> logWater() async {
    try {
      final hydration = await _logWater(state.selectedDay);
      final dashboard = state.dashboard;
      if (dashboard == null) return;

      emit(
        state.copyWith(
          dashboard: HomeDashboard(
            date: dashboard.date,
            workout: dashboard.workout,
            calories: dashboard.calories,
            weight: dashboard.weight,
            hydration: hydration,
          ),
        ),
      );
    } on AppException catch (error) {
      emit(state.copyWith(errorMessage: error.message));
    }
  }
}
