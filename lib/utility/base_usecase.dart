import 'package:dartz/dartz.dart';

abstract class BaseUseCase<Type, Params> {
  Future<Either<Type, Error>> call({required Params params});
}

class NoParams {}
