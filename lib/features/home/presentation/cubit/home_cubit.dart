import 'package:evencir_app/core/error/exceptions.dart';
import 'package:evencir_app/features/home/domain/entities/home_dashboard.dart';
import 'package:evencir_app/features/home/domain/usecases/get_home_dashboard.dart';
import 'package:evencir_app/features/home/domain/usecases/log_water.dart';
import 'package:evencir_app/features/home/presentation/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required GetHomeDashboard getHomeDashboard,
    required LogWater logWater,
  }) : _getHomeDashboard = getHomeDashboard,
       _logWater = logWater,
       super(const HomeState());

  final GetHomeDashboard _getHomeDashboard;
  final LogWater _logWater;

  Future<void> load(DateTime date) async {
    emit(state.copyWith(status: HomeStatus.loading, errorMessage: null));
    try {
      final dashboard = await _getHomeDashboard(date);
      emit(
        state.copyWith(status: HomeStatus.success, dashboard: dashboard),
      );
    } on AppException catch (error) {
      emit(
        state.copyWith(
          status: HomeStatus.failure,
          errorMessage: error.message,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: HomeStatus.failure,
          errorMessage: 'Failed to load dashboard',
        ),
      );
    }
  }

  Future<void> logWater(DateTime date) async {
    try {
      final hydration = await _logWater(date);
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
