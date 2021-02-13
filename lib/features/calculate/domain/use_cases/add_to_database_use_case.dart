import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:vaTask/core/database/database_helper.dart';
import 'package:vaTask/core/error/failures.dart';
import 'package:vaTask/features/calculate/domain/repositories/calculate_repo.dart';

@lazySingleton
class AddToDataBaseUseCase {
  final CalculateRepo _repo;

  AddToDataBaseUseCase(this._repo);

  Future<Either<Failure, DataBaseModel>> call(
      DataBaseModel model) async {
    print("Model : ${model.status}");
    return await _repo.addToDataBase(model);
  }
}
