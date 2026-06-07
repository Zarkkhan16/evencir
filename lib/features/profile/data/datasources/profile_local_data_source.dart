import 'package:evencir_app/features/profile/data/datasources/profile_data_source.dart';
import 'package:evencir_app/features/profile/data/models/user_profile_model.dart';

class ProfileLocalDataSource implements ProfileDataSource {
  @override
  Future<UserProfileModel> getProfile() async {
    return const UserProfileModel(
      displayName: 'Your Profile',
      subtitle: 'Settings and account details',
      menuItems: [
        ProfileMenuItemModel(iconName: 'notifications', title: 'Notifications'),
        ProfileMenuItemModel(iconName: 'privacy', title: 'Privacy'),
        ProfileMenuItemModel(iconName: 'help', title: 'Help & Support'),
        ProfileMenuItemModel(iconName: 'logout', title: 'Sign Out'),
      ],
    );
  }
}
