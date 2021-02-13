import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vaTask/core/database/database_helper.dart';
import 'package:vaTask/core/operations_model.dart';
import 'package:vaTask/features/history/domain/repositories/history_repo.dart';
import 'package:vaTask/features/history/domain/use_cases/get_pending_jobs_usecase.dart';

class MockHistoryRepo extends Mock implements HistoryRepo {}

void main() {
  MockHistoryRepo repo;
  GetPendingJobsUsCase pendingJobsUsCase;
  setUp(() {
    repo = MockHistoryRepo();
    pendingJobsUsCase = GetPendingJobsUsCase(repo);
  });

  test('should return list of pending jobs ', () async {
    final tPendingJobsList = [
      DataBaseModel(
          id: '1',
          firstNum: 10,
          secondNum: 20,
          operation: Operations('Add', 'ADD', 1),
          status: 'Pending')
    ];

    when(repo.getPendingJobs())
        .thenAnswer((_) async => Right(tPendingJobsList));
    final result = await pendingJobsUsCase();
    expect(result, Right(tPendingJobsList));
    verify(repo.getPendingJobs());
    verifyNoMoreInteractions(repo);
  });
}
