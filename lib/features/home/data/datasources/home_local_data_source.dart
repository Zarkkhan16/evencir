import 'package:evencir_app/features/home/data/datasources/home_data_source.dart';
import 'package:evencir_app/features/home/data/models/home_dashboard_model.dart';
import 'package:evencir_app/features/home/data/models/home_models.dart';

class HomeLocalDataSource implements HomeDataSource {
  final Map<String, double> _hydrationByDate = {
    _dateKey(DateTime(2024, 12, 22)): 0,
    _dateKey(DateTime(2024, 9, 22)): 0.35,
  };

  static String _dateKey(DateTime date) {
    return '${date.year}-${date.month}-${date.day}';
  }

  @override
  Future<HomeDashboardModel> getDashboard(DateTime date) async {
    final key = _dateKey(date);
    final progress = _hydrationByDate[key] ?? 0;

    return HomeDashboardModel(
      date: date,
      workout: const WorkoutModel(
        title: 'Upper Body',
        dateRange: 'December 22 - 25m - 30m',
        duration: '25m - 30m',
      ),
      calories: const MetricInsightModel(
        label: 'Calories',
        value: '550',
        subtitle: '1950 Remaining',
      ),
      weight: const MetricInsightModel(
        label: 'Weight',
        value: '75 kg',
        subtitle: 'Last updated',
        trend: '+1.6kg',
      ),
      hydration: HydrationModel(progress: progress),
    );
  }

  @override
  Future<HydrationModel> logWater(DateTime date) async {
    final key = _dateKey(date);
    final current = _hydrationByDate[key] ?? 0;
    final updated = (current + 0.125).clamp(0.0, 1.0);
    _hydrationByDate[key] = updated;

    return HydrationModel(progress: updated);
  }
}
