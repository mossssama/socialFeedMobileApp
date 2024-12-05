import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:social_feed/core/constants.dart';

import '../features/auth/data/api/login_api.dart';
import '../features/auth/data/api/login_api_firebase_impl.dart';
import '../features/auth/data/api/register_api.dart';
import '../features/auth/data/api/register_api_firebase_impl.dart';
import '../features/auth/data/repos/login_repo_impl.dart';
import '../features/auth/data/repos/register_repo_impl.dart';
import '../features/auth/domain/repos/login_repo.dart';
import '../features/auth/domain/repos/register_repo.dart';
import '../features/auth/domain/use_cases/login_use_case.dart';
import '../features/auth/domain/use_cases/logout_use_case.dart';
import '../features/auth/domain/use_cases/register_use_case.dart';
import '../features/auth/presentation/controllers/login_cubit.dart';
import '../features/auth/presentation/controllers/logout_cubit.dart';
import '../features/auth/presentation/controllers/register_cubit.dart';
import '../features/feed/data/api/feed_api.dart';
import '../features/feed/data/api/feed_api_dio_impl.dart';
import '../features/feed/data/repos/feeds_repo_impl.dart';
import '../features/feed/domain/repos/feeds_repo.dart';
import '../features/feed/domain/use_cases/feeds_use_case.dart';
import '../features/feed/presentation/controllers/feeds_cubit.dart';
import 'dio_client.dart';
import 'firebase_client.dart';
import 'routing.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerSingleton<AppRouter>(AppRouter());
  getIt.registerSingleton<Logger>(Logger());
  getIt.registerSingleton<Box>(Hive.box(hiveFeedCacheBox));

  getIt.registerSingleton<DioClient>(DioClient(logger: getIt<Logger>()));
  getIt.registerSingleton<FirebaseClient>(FirebaseClient(logger: getIt<Logger>()));

  getIt.registerSingleton<FeedApi>(FeedApiDioImpl(getIt<DioClient>()));
  getIt.registerSingleton<FeedsRepository>(FeedRepoistoryImpl(getIt<Box>(), getIt<FeedApi>()));
  getIt.registerSingleton<GetFeedsUseCase>(GetFeedsUseCase(getIt<FeedsRepository>()));
  getIt.registerFactory<FeedsCubit>(() => FeedsCubit(getIt<GetFeedsUseCase>()));

  getIt.registerSingleton<RegisterApi>(RegisterApiFirebaseImpl(getIt<FirebaseClient>()));
  getIt.registerSingleton<RegisterRepository>(RegisterRepositoryImpl(getIt<RegisterApi>()));
  getIt.registerSingleton<RegisterUseCase>(RegisterUseCase(getIt<RegisterRepository>()));
  getIt.registerSingleton<RegisterCubit>(RegisterCubit(getIt<RegisterUseCase>()));

  getIt.registerSingleton<LoginApi>(LoginApiFirebaseImpl(getIt<FirebaseClient>()));
  getIt.registerSingleton<LoginRepository>(LoginRepositoryImpl(getIt<LoginApi>()));

  getIt.registerSingleton<LoginUseCase>(LoginUseCase(getIt<LoginRepository>()));
  getIt.registerSingleton<LoginCubit>(LoginCubit(getIt<LoginUseCase>()));

  getIt.registerSingleton<LogoutUseCase>(LogoutUseCase(getIt<LoginRepository>()));
  getIt.registerSingleton<LogoutCubit>(LogoutCubit(getIt<LogoutUseCase>()));
}
