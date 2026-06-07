import 'package:evencir_app/features/profile/data/models/user_profile_model.dart';

abstract interface class ProfileDataSource {
  Future<UserProfileModel> getProfile();
}
