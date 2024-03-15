import 'package:algeria_eats/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

typedef EitherArtisan<T> = Future<Either<Failure, T>>;

typedef EitherUser<T> = Future<Either<Failure, T>>;

typedef EitherOrder<T> = Future<Either<Failure, T>>;

typedef EitherProduct<T> = Future<Either<Failure, T>>;
