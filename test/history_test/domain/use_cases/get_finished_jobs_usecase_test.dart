import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vaTask/core/database/database_helper.dart';
import 'package:vaTask/core/operations_model.dart';
import 'package:vaTask/features/history/domain/repositories/history_repo.dart';
import 'package:vaTask/features/history/domain/use_cases/get_finished_jobs_usecase.dart';

class MockHistoryRepo extends Mock implements HistoryRepo {}

void main() {
  MockHistoryRepo repo;
  GetFinishedJobsUseCase finishedJobsUseCase;
  setUp(() {
    repo = MockHistoryRepo();
    finishedJobsUseCase = GetFinishedJobsUseCase(repo);
  });

  test('should return list of finished jobs ', () async {
    final tFinishedJobsList = [
      DataBaseModel(
          id: '1',
          firstNum: 10,
          secondNum: 20,
          operation: Operations('Add', 'ADD', 1),
          status: 'Finished',
          result: '30')
    ];

    when(repo.getFinishedJobs())
        .thenAnswer((_) async => Right(tFinishedJobsList));
    final result = await finishedJobsUseCase();
    expect(result, Right(tFinishedJobsList));
    verify(repo.getFinishedJobs());
    verifyNoMoreInteractions(repo);
  });
}
