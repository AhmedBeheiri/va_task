import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vaTask/core/database/database_helper.dart';
import 'package:vaTask/core/error/exception.dart';
import 'package:vaTask/core/error/failures.dart';
import 'package:vaTask/core/operations_model.dart';
import 'package:vaTask/features/history/data/data_sources/history_local_data_source.dart';
import 'package:vaTask/features/history/data/repositories/history_repo_impl.dart';

class MockLocalDataSource extends Mock implements HistoryLocalDataSource {}

void main() {
  MockLocalDataSource mockLocalDataSource;
  HistoryRepoImpl repo;

  setUp(() {
    mockLocalDataSource = MockLocalDataSource();
    repo = HistoryRepoImpl(mockLocalDataSource);
  });

  group('success tests', () {
    var tPendingOperations = [
      DataBaseModel(
          id: '1',
          firstNum: 10,
          secondNum: 20,
          operation: Operations('Add', 'ADD', 1),
          status: 'Pending')
    ];

    var tFinishedOperations = [
      DataBaseModel(
          id: '1',
          firstNum: 10,
          secondNum: 20,
          operation: Operations('Add', 'ADD', 1),
          status: 'Finished',
          result: '30')
    ];

    test('should return list of pending operations', () async {
      when(mockLocalDataSource.getPendingJobs())
          .thenAnswer((_) async => tPendingOperations);
      final result = await repo.getPendingJobs();
      verify(mockLocalDataSource.getPendingJobs());
      verifyNoMoreInteractions(mockLocalDataSource);
      expect(result, Right(tPendingOperations));
    });
    test('should return list of finished operations', () async {
      when(mockLocalDataSource.getFinishedJobs())
          .thenAnswer((_) async => tFinishedOperations);
      final result = await repo.getFinishedJobs();
      verify(mockLocalDataSource.getFinishedJobs());
      verifyNoMoreInteractions(mockLocalDataSource);
      expect(result, Right(tFinishedOperations));
    });
  });

  group('cache failure', () {
    String message = "Test Throw Exception";
    test('should throw CacheException on get pending list', () async {
      when(mockLocalDataSource.getPendingJobs())
          .thenThrow(CacheException(message));
      final result = await repo.getPendingJobs();
      verify(mockLocalDataSource.getPendingJobs());
      verifyNoMoreInteractions(mockLocalDataSource);
      expect(result, Left(CacheFailure(message)));
    });

    test('should throw CacheException on get finished list', () async {
      when(mockLocalDataSource.getFinishedJobs())
          .thenThrow(CacheException(message));
      final result = await repo.getFinishedJobs();
      verify(mockLocalDataSource.getFinishedJobs());
      verifyNoMoreInteractions(mockLocalDataSource);
      expect(result, Left(CacheFailure(message)));
    });
  });
}
