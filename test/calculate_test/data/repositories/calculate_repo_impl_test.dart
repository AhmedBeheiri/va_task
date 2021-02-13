import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vaTask/core/database/database_helper.dart';
import 'package:vaTask/core/error/exception.dart';
import 'package:vaTask/core/error/failures.dart';
import 'package:vaTask/core/operations_model.dart';
import 'package:vaTask/features/calculate/data/data_sources/calculate_local_data_source.dart';
import 'package:vaTask/features/calculate/data/repositories/calculate_repo_impl.dart';

class MockLocalDataSource extends Mock implements CalculateLocalDataSource {}

void main() {
  CalculateRepoImpl calculateRepo;
  MockLocalDataSource mockLocalDataSource;
  setUp(() {
    mockLocalDataSource = MockLocalDataSource();
    calculateRepo = CalculateRepoImpl(mockLocalDataSource);
  });

  group('save data before and after calculation', () {
    final tOperationModelPending = DataBaseModel(
        id: '1',
        firstNum: 10,
        secondNum: 20,
        operation: Operations('Add', 'ADD', 1),
        status: 'Pending');
    final tOperationModelFinished = DataBaseModel(
        id: '1',
        firstNum: 10,
        secondNum: 20,
        operation: Operations('Add', 'ADD', 1),
        status: 'Finished',
        result: '30');
    test('should save pending model and return the model', () async {
      when(mockLocalDataSource.addDataBaseModel(tOperationModelPending))
          .thenAnswer((_) async => tOperationModelPending);
      final result = await calculateRepo.addToDataBase(tOperationModelPending);
      verify(mockLocalDataSource.addDataBaseModel(tOperationModelPending));
      expect(result, equals(Right(tOperationModelPending)));
    });

    test('should save finished model and return the model', () async {
      when(mockLocalDataSource.addDataBaseModel(tOperationModelFinished))
          .thenAnswer((_) async => tOperationModelFinished);
      final result = await calculateRepo.addToDataBase(tOperationModelFinished);
      verify(mockLocalDataSource.addDataBaseModel(tOperationModelFinished));
      expect(result, equals(Right(tOperationModelFinished)));
    });
  });

  group('cache exception', () {
    final tOperationModelPending = DataBaseModel(
        id: '1',
        firstNum: 10,
        secondNum: 20,
        operation: Operations('Add', 'ADD', 1),
        status: 'Pending');
    final tOperationModelFinished = DataBaseModel(
        id: '1',
        firstNum: 10,
        secondNum: 20,
        operation: Operations('Add', 'ADD', 1),
        status: 'Finished',
        result: '30');
    String message = "Test Throw Exception";
    test('should return cache Exception on adding pending ', () async {
      when(mockLocalDataSource.addDataBaseModel(tOperationModelPending))
          .thenThrow(CacheException(message));
      final result = await calculateRepo.addToDataBase(tOperationModelPending);
      verify(mockLocalDataSource.addDataBaseModel(tOperationModelPending));
      expect(result, equals(Left(CacheFailure(message))));
    });

    test('should return cache Exception on adding finished ', () async {
      when(mockLocalDataSource.addDataBaseModel(tOperationModelFinished))
          .thenThrow(CacheException(message));
      final result = await calculateRepo.addToDataBase(tOperationModelFinished);
      verify(mockLocalDataSource.addDataBaseModel(tOperationModelFinished));
      expect(result, equals(Left(CacheFailure(message))));
    });
  });
}
