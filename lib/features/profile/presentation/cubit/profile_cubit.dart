import 'package:evencir_app/core/error/exceptions.dart';
import 'package:evencir_app/core/usecases/usecase.dart';
import 'package:evencir_app/features/profile/domain/usecases/get_profile.dart';
import 'package:evencir_app/features/profile/presentation/cubit/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required GetProfile getProfile})
    : _getProfile = getProfile,
      super(const ProfileState());

  final GetProfile _getProfile;

  Future<void> load() async {
    emit(state.copyWith(status: ProfileStatus.loading, errorMessage: null));
    try {
      final profile = await _getProfile(const NoParams());
      emit(
        state.copyWith(status: ProfileStatus.success, profile: profile),
      );
    } on AppException catch (error) {
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: error.message,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: 'Failed to load profile',
        ),
      );
    }
  }
}
