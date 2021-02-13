import 'package:dartz/dartz.dart';
import 'package:vaTask/core/database/database_helper.dart';
import 'package:vaTask/core/error/failures.dart';

abstract class CalculateRepo {
  Future<Either<Failure, DataBaseModel>> addToDataBase(
      DataBaseModel model);
}
