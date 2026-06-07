import 'package:evencir_app/features/calendar/data/datasources/calendar_data_source.dart';
import 'package:evencir_app/features/calendar/data/datasources/calendar_local_data_source.dart';
import 'package:evencir_app/features/calendar/data/repositories/calendar_repository_impl.dart';
import 'package:evencir_app/features/calendar/domain/repositories/calendar_repository.dart';
import 'package:evencir_app/features/calendar/domain/usecases/get_marked_dates.dart';
import 'package:evencir_app/features/calendar/presentation/cubit/calendar_cubit.dart';
import 'package:evencir_app/features/home/data/datasources/home_data_source.dart';
import 'package:evencir_app/features/home/data/datasources/home_local_data_source.dart';
import 'package:evencir_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:evencir_app/features/home/domain/repositories/home_repository.dart';
import 'package:evencir_app/features/home/domain/usecases/get_home_dashboard.dart';
import 'package:evencir_app/features/home/domain/usecases/log_water.dart';
import 'package:evencir_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:evencir_app/features/mood/data/datasources/mood_data_source.dart';
import 'package:evencir_app/features/mood/data/datasources/mood_local_data_source.dart';
import 'package:evencir_app/features/mood/data/repositories/mood_repository_impl.dart';
import 'package:evencir_app/features/mood/domain/repositories/mood_repository.dart';
import 'package:evencir_app/features/mood/domain/usecases/submit_mood.dart';
import 'package:evencir_app/features/mood/presentation/cubit/mood_cubit.dart';
import 'package:evencir_app/features/profile/data/datasources/profile_data_source.dart';
import 'package:evencir_app/features/profile/data/datasources/profile_local_data_source.dart';
import 'package:evencir_app/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:evencir_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:evencir_app/features/profile/domain/usecases/get_profile.dart';
import 'package:evencir_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:evencir_app/features/training_plan/data/datasources/training_plan_data_source.dart';
import 'package:evencir_app/features/training_plan/data/datasources/training_plan_local_data_source.dart';
import 'package:evencir_app/features/training_plan/data/repositories/training_plan_repository_impl.dart';
import 'package:evencir_app/features/training_plan/domain/repositories/training_plan_repository.dart';
import 'package:evencir_app/features/training_plan/domain/usecases/training_plan_usecases.dart';
import 'package:evencir_app/features/training_plan/presentation/cubit/training_plan_cubit.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

Future<void> configureDependencies() async {
  _registerHome();
  _registerCalendar();
  _registerTrainingPlan();
  _registerMood();
  _registerProfile();
}

void _registerHome() {
  sl.registerLazySingleton<HomeDataSource>(HomeLocalDataSource.new);
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(sl()));
  sl.registerLazySingleton(() => GetHomeDashboard(sl()));
  sl.registerLazySingleton(() => LogWater(sl()));
  sl.registerFactory(
    () => HomeCubit(getHomeDashboard: sl(), logWater: sl()),
  );
}

void _registerCalendar() {
  sl.registerLazySingleton<CalendarDataSource>(CalendarLocalDataSource.new);
  sl.registerLazySingleton<CalendarRepository>(
    () => CalendarRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => GetMarkedDates(sl()));
  sl.registerFactory(
    () => CalendarCubit(
      getMarkedDates: sl(),
      getHomeDashboard: sl(),
      logWater: sl(),
    ),
  );
}

void _registerTrainingPlan() {
  sl.registerLazySingleton<TrainingPlanDataSource>(
    TrainingPlanLocalDataSource.new,
  );
  sl.registerLazySingleton<TrainingPlanRepository>(
    () => TrainingPlanRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => GetTrainingPlan(sl()));
  sl.registerLazySingleton(() => SaveTrainingPlan(sl()));
  sl.registerFactory(
    () => TrainingPlanCubit(
      getTrainingPlan: sl(),
      saveTrainingPlan: sl(),
    ),
  );
}

void _registerMood() {
  sl.registerLazySingleton<MoodDataSource>(MoodLocalDataSource.new);
  sl.registerLazySingleton<MoodRepository>(() => MoodRepositoryImpl(sl()));
  sl.registerLazySingleton(() => SubmitMood(sl()));
  sl.registerFactory(() => MoodCubit(submitMood: sl()));
}

void _registerProfile() {
  sl.registerLazySingleton<ProfileDataSource>(ProfileLocalDataSource.new);
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => GetProfile(sl()));
  sl.registerFactory(() => ProfileCubit(getProfile: sl()));
}
