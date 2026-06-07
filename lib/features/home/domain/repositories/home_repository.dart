import 'package:evencir_app/features/home/domain/entities/home_dashboard.dart';
import 'package:evencir_app/features/home/domain/entities/hydration.dart';

abstract interface class HomeRepository {
  Future<HomeDashboard> getDashboard(DateTime date);
  Future<Hydration> logWater(DateTime date);
}
