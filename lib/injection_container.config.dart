// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'features/calculate/domain/use_cases/add_to_database_use_case.dart';
import 'features/calculate/data/data_sources/calculate_local_data_source.dart';
import 'features/calculate/presentation/manager/calculate_manager.dart';
import 'features/calculate/domain/repositories/calculate_repo.dart';
import 'features/calculate/data/repositories/calculate_repo_impl.dart';
import 'core/database/database_helper.dart';
import 'features/history/domain/use_cases/get_finished_jobs_usecase.dart';
import 'features/history/domain/use_cases/get_pending_jobs_usecase.dart';
import 'features/history/data/data_sources/history_local_data_source.dart';
import 'features/history/presentation/manager/history_provider.dart';
import 'features/history/domain/repositories/history_repo.dart';
import 'features/history/data/repositories/history_repo_impl.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<DataBaseHelper>(() => DataBaseHelper());
  gh.lazySingleton<HistoryLocalDataSource>(
      () => HistoryLocalDataSourceImpl(get<DataBaseHelper>()));
  gh.lazySingleton<HistoryRepo>(
      () => HistoryRepoImpl(get<HistoryLocalDataSource>()));
  gh.lazySingleton<CalculateLocalDataSource>(
      () => CalculateLocalDataSourceImpl(get<DataBaseHelper>()));
  gh.lazySingleton<CalculateRepo>(
      () => CalculateRepoImpl(get<CalculateLocalDataSource>()));
  gh.lazySingleton<GetFinishedJobsUseCase>(
      () => GetFinishedJobsUseCase(get<HistoryRepo>()));
  gh.lazySingleton<GetPendingJobsUsCase>(
      () => GetPendingJobsUsCase(get<HistoryRepo>()));
  gh.factory<HistoryProvider>(() => HistoryProvider(
      get<GetFinishedJobsUseCase>(), get<GetPendingJobsUsCase>()));
  gh.lazySingleton<AddToDataBaseUseCase>(
      () => AddToDataBaseUseCase(get<CalculateRepo>()));
  gh.factory<CalculateManager>(
      () => CalculateManager(get<AddToDataBaseUseCase>()));
  return get;
}
