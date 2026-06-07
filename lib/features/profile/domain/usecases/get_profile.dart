import 'package:evencir_app/core/usecases/usecase.dart';
import 'package:evencir_app/features/profile/domain/entities/user_profile.dart';
import 'package:evencir_app/features/profile/domain/repositories/profile_repository.dart';

class GetProfile implements UseCase<UserProfile, NoParams> {
  GetProfile(this._repository);

  final ProfileRepository _repository;

  @override
  Future<UserProfile> call(NoParams params) {
    return _repository.getProfile();
  }
}
