typedef EitherUser = Future<Either<Failure, User>>;
typedef EitherUser<T> = Future<Either<Failure, T>>;
//create class for typedefs and a class for Failure