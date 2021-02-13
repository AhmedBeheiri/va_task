import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:vaTask/core/database/database_helper.dart';
import 'package:vaTask/core/error/exception.dart';
import 'package:vaTask/core/error/failures.dart';
import 'package:vaTask/features/history/data/data_sources/history_local_data_source.dart';
import 'package:vaTask/features/history/domain/repositories/history_repo.dart';

@LazySingleton(as: HistoryRepo)
class HistoryRepoImpl implements HistoryRepo {
  final HistoryLocalDataSource _localDataSource;

  HistoryRepoImpl(this._localDataSource);

  @override
  Future<Either<Failure, List<DataBaseModel>>>
      getFinishedJobs() async {
    try {
      return Right(await _localDataSource.getFinishedJobs());
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<DataBaseModel>>>
      getPendingJobs() async {
    try {
      return Right(await _localDataSource.getPendingJobs());
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }
}
