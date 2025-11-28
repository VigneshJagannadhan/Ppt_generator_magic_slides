import 'package:indian_app_guy/core/services/api_service.dart';
import 'package:get_it/get_it.dart';
import 'package:indian_app_guy/core/services/ppt_service.dart';
import 'package:indian_app_guy/core/services/storage_service.dart';
import 'package:indian_app_guy/core/services/supabase_service.dart';
import 'package:indian_app_guy/features/Home/data/data_sources/home_data_source.dart';
import 'package:indian_app_guy/features/Home/data/repositories/home_repository_impl.dart';
import 'package:indian_app_guy/features/Home/domain/repositories/home_repository.dart';

final locator = GetIt.instance;

setupLocator() {
  locator.registerLazySingleton(() => ApiService());

  locator.registerLazySingleton(() => SupabaseService());

  locator.registerLazySingleton(() => StorageService());

  locator.registerLazySingleton(() => PptService());

  locator.registerFactory<HomeDataSource>(
    () => HomeDataSourceImpl(apiService: locator<ApiService>()),
  );

  locator.registerFactory<HomeRepository>(
    () => HomeRepositoryImpl(dataSource: locator<HomeDataSource>()),
  );
}
