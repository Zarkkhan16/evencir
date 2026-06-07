import 'package:evencir_app/core/usecases/usecase.dart';
import 'package:evencir_app/features/home/domain/entities/home_dashboard.dart';
import 'package:evencir_app/features/home/domain/repositories/home_repository.dart';

class GetHomeDashboard implements UseCase<HomeDashboard, DateTime> {
  GetHomeDashboard(this._repository);

  final HomeRepository _repository;

  @override
  Future<HomeDashboard> call(DateTime params) {
    return _repository.getDashboard(params);
  }
}
