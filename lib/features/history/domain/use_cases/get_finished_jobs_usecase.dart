import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:vaTask/core/database/database_helper.dart';
import 'package:vaTask/core/error/failures.dart';
import 'package:vaTask/features/history/domain/repositories/history_repo.dart';

@lazySingleton
class GetFinishedJobsUseCase {
  final HistoryRepo _repo;

  GetFinishedJobsUseCase(this._repo);

  Future<Either<Failure, List<DataBaseModel>>> call() async =>
      await _repo.getFinishedJobs();
}
