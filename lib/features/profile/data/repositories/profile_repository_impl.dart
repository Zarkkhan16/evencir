import 'package:evencir_app/features/profile/data/datasources/profile_data_source.dart';
import 'package:evencir_app/features/profile/domain/entities/user_profile.dart';
import 'package:evencir_app/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(this._dataSource);

  final ProfileDataSource _dataSource;

  @override
  Future<UserProfile> getProfile() async {
    final model = await _dataSource.getProfile();
    return model.toEntity();
  }
}
