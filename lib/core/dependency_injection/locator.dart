import 'package:get_it/get_it.dart';
import 'package:my_budget/auth/data/data_sources/auth_data_source.dart';
import 'package:my_budget/auth/data/data_sources/auth_data_source_remote.dart';
import 'package:my_budget/auth/data/repositories/auth_repository_implementation.dart';
import 'package:my_budget/auth/domain/repositories/auth_repository.dart';
import 'package:stacked_services/stacked_services.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
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
}
