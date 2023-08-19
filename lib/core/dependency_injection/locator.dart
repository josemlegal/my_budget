import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:my_budget/application/services/shared_preferences_service.dart';
import 'package:my_budget/auth/data/data_sources/auth_data_source.dart';
import 'package:my_budget/auth/data/data_sources/auth_data_source_remote.dart';
import 'package:my_budget/auth/data/repositories/auth_repository_implementation.dart';
import 'package:my_budget/auth/domain/repositories/auth_repository.dart';
import 'package:my_budget/user/data/repositories/user_repository_implementation.dart';
import 'package:my_budget/user/domain/repositories/user_repository.dart';
import 'package:stacked_services/stacked_services.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<SharedPreferenceApi>(
      () => SharedPreferencesService());

  locator.registerLazySingleton<NavigationService>(
    () => NavigationService(),
  );

  locator.registerLazySingleton<DialogService>(
    () => DialogService(),
  );

  locator.registerLazySingleton<SnackbarService>(
    () => SnackbarService(),
  );

  locator.registerLazySingleton<AuthDataSource>(
    () => AuthDataSourceRemote(),
  );

  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImplementation(),
  );

  locator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImplementation(
      firestore: FirebaseFirestore.instance,
      authRepository: locator<AuthRepository>(),
    ),
  );
}
