import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:vaTask/core/database/database_helper.dart';
import 'package:vaTask/core/error/failures.dart';
import 'package:vaTask/features/history/domain/repositories/history_repo.dart';

@lazySingleton
class GetPendingJobsUsCase {
  final HistoryRepo _repo;

  GetPendingJobsUsCase(this._repo);

  Future<Either<Failure, List<DataBaseModel>>> call() async =>
      await _repo.getPendingJobs();
}
