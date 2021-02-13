import 'package:dartz/dartz.dart';
import 'package:vaTask/core/database/database_helper.dart';
import 'package:vaTask/core/error/failures.dart';

abstract class HistoryRepo {
  Future<Either<Failure, List<DataBaseModel>>> getPendingJobs();
  Future<Either<Failure, List<DataBaseModel>>> getFinishedJobs();
}
