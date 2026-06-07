import 'package:evencir_app/core/usecases/usecase.dart';
import 'package:evencir_app/features/home/domain/entities/hydration.dart';
import 'package:evencir_app/features/home/domain/repositories/home_repository.dart';

class LogWater implements UseCase<Hydration, DateTime> {
  LogWater(this._repository);

  final HomeRepository _repository;

  @override
  Future<Hydration> call(DateTime params) {
    return _repository.logWater(params);
  }
}
