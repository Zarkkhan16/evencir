import 'package:evencir_app/features/home/data/datasources/home_data_source.dart';
import 'package:evencir_app/features/home/domain/entities/home_dashboard.dart';
import 'package:evencir_app/features/home/domain/entities/hydration.dart';
import 'package:evencir_app/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl(this._dataSource);

  final HomeDataSource _dataSource;

  @override
  Future<HomeDashboard> getDashboard(DateTime date) async {
    final model = await _dataSource.getDashboard(date);
    return model.toEntity();
  }

  @override
  Future<Hydration> logWater(DateTime date) async {
    final model = await _dataSource.logWater(date);
    return model.toEntity();
  }
}
