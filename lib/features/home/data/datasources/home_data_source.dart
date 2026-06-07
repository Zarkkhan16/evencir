import 'package:evencir_app/features/home/data/models/home_dashboard_model.dart';
import 'package:evencir_app/features/home/data/models/home_models.dart';

abstract interface class HomeDataSource {
  Future<HomeDashboardModel> getDashboard(DateTime date);
  Future<HydrationModel> logWater(DateTime date);
}
