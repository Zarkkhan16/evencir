import 'package:equatable/equatable.dart';

class Hydration extends Equatable {
  const Hydration({required this.progress});

  final double progress;

  @override
  List<Object?> get props => [progress];
}
