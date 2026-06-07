import 'package:evencir_app/features/profile/domain/entities/user_profile.dart';

abstract interface class ProfileRepository {
  Future<UserProfile> getProfile();
}
