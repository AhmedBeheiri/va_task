import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vaTask/core/database/database_helper.dart';
import 'package:vaTask/core/operations_model.dart';
import 'package:vaTask/features/calculate/domain/repositories/calculate_repo.dart';
import 'package:vaTask/features/calculate/domain/use_cases/add_to_database_use_case.dart';

class MockCalculateRepo extends Mock implements CalculateRepo {}

main() {
  MockCalculateRepo repo;
  AddToDataBaseUseCase addToDataBaseUseCase;
  setUp(() {
    repo = MockCalculateRepo();
    addToDataBaseUseCase = AddToDataBaseUseCase(repo);
  });
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
  test('should add pending operation to database and return it', () async {
    when(repo.addToDataBase(any))
        .thenAnswer((_) async => Right(tOperationModelPending));
    final result = await addToDataBaseUseCase(tOperationModelPending);
    expect(result, Right(tOperationModelPending));
    verify(repo.addToDataBase(tOperationModelPending));
    verifyNoMoreInteractions(repo);
  });

  test('should add finished operation to database and return it', () async {
    when(repo.addToDataBase(any))
        .thenAnswer((_) async => Right(tOperationModelFinished));
    final result = await addToDataBaseUseCase(tOperationModelFinished);
    expect(result, Right(tOperationModelFinished));
    verify(repo.addToDataBase(tOperationModelFinished));
    verifyNoMoreInteractions(repo);
  });
}
