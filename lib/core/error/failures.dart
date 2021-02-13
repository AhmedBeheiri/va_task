import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure([List properties = const <dynamic>[]]) : super();
}

class CacheFailure extends Failure {
  final String message;

  CacheFailure(this.message);
  @override
  List<Object> get props => [message];
}
