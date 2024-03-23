import 'package:algeria_eats/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
