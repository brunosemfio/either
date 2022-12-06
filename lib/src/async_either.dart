import 'package:either/either.dart';

typedef AsyncEither<L, R> = Future<Either<L, R>>;

extension AsyncEitherExt<L, R> on AsyncEither<L, R> {
  AsyncEither<L, T> map<T>(T Function(R right) fn) {
    return then((value) => value.map(fn));
  }

  AsyncEither<T, R> mapError<T>(T Function(L left) fn) {
    return then((value) => value.mapError(fn));
  }

  AsyncEither<L, T> flatMap<T>(AsyncEither<L, T> Function(R right) fn) {
    return then((value) => value.when(left, fn));
  }
}
