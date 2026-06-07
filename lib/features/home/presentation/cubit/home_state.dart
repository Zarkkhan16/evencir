import 'package:equatable/equatable.dart';
import 'package:evencir_app/features/home/domain/entities/home_dashboard.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
    this.dashboard,
    this.errorMessage,
  });

  final HomeStatus status;
  final HomeDashboard? dashboard;
  final String? errorMessage;

  HomeState copyWith({
    HomeStatus? status,
    HomeDashboard? dashboard,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      dashboard: dashboard ?? this.dashboard,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, dashboard, errorMessage];
}
