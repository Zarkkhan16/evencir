import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ProfileMenuItem extends Equatable {
  const ProfileMenuItem({
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;

  @override
  List<Object?> get props => [icon, title];
}

class UserProfile extends Equatable {
  const UserProfile({
    required this.displayName,
    required this.subtitle,
    required this.menuItems,
  });

  final String displayName;
  final String subtitle;
  final List<ProfileMenuItem> menuItems;

  @override
  List<Object?> get props => [displayName, subtitle, menuItems];
}
