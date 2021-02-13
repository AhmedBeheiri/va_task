import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:vaTask/core/error/exception.dart';
import 'package:vaTask/core/error/failures.dart';
import 'package:vaTask/core/database/database_helper.dart';
import 'package:vaTask/features/calculate/data/data_sources/calculate_local_data_source.dart';
import 'package:vaTask/features/calculate/domain/repositories/calculate_repo.dart';

@LazySingleton(as: CalculateRepo)
class CalculateRepoImpl implements CalculateRepo {
  final CalculateLocalDataSource _localDataSource;

  CalculateRepoImpl(this._localDataSource);

  @override
  Future<Either<Failure, DataBaseModel>> addToDataBase(
      DataBaseModel model) async {
    try {
      return Right(await _localDataSource.addDataBaseModel(model));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }
}
