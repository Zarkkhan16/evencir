import 'package:evencir_app/features/profile/domain/entities/user_profile.dart';
import 'package:flutter/material.dart';

class ProfileMenuItemModel {
  const ProfileMenuItemModel({
    required this.iconName,
    required this.title,
  });

  factory ProfileMenuItemModel.fromJson(Map<String, dynamic> json) {
    return ProfileMenuItemModel(
      iconName: json['icon'] as String,
      title: json['title'] as String,
    );
  }

  final String iconName;
  final String title;

  Map<String, dynamic> toJson() => {'icon': iconName, 'title': title};

  ProfileMenuItem toEntity() {
    return ProfileMenuItem(icon: _mapIcon(iconName), title: title);
  }

  static IconData _mapIcon(String name) {
    return switch (name) {
      'notifications' => Icons.notifications_outlined,
      'privacy' => Icons.lock_outline,
      'help' => Icons.help_outline,
      'logout' => Icons.logout,
      _ => Icons.circle_outlined,
    };
  }
}

class UserProfileModel {
  const UserProfileModel({
    required this.displayName,
    required this.subtitle,
    required this.menuItems,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      displayName: json['display_name'] as String,
      subtitle: json['subtitle'] as String,
      menuItems: (json['menu_items'] as List<dynamic>)
          .map(
            (item) =>
                ProfileMenuItemModel.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  final String displayName;
  final String subtitle;
  final List<ProfileMenuItemModel> menuItems;

  Map<String, dynamic> toJson() => {
    'display_name': displayName,
    'subtitle': subtitle,
    'menu_items': menuItems.map((item) => item.toJson()).toList(),
  };

  UserProfile toEntity() {
    return UserProfile(
      displayName: displayName,
      subtitle: subtitle,
      menuItems: menuItems.map((item) => item.toEntity()).toList(),
    );
  }
}
