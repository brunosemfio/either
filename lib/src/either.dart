T id<T>(T value) => value;

Either<L, R> left<L, R>(L left) => _Left<L, R>(left);

Either<L, R> right<L, R>(R right) => _Right<L, R>(right);

abstract class Either<L, R> {
  bool get isLeft;
  bool get isRight;

  T when<T>(
    T Function(L error) whenLeft,
    T Function(R success) whenRight,
  );

  Either<L, T> map<T>(T Function(R right) fn) {
    return when(left, (success) => right(fn(success)));
  }

  Either<T, R> mapError<T>(T Function(L left) fn) {
    return when((error) => left(fn(error)), right);
  }

  Either<L, T> flatMap<T>(Either<L, T> Function(R right) fn) {
    return when(left, fn);
  }
}

class _Left<L, R> extends Either<L, R> {
  _Left(this._value);

  final L _value;

  @override
  bool get isLeft => true;

  @override
  bool get isRight => false;

  @override
  T when<T>(
    T Function(L error) whenLeft,
    T Function(R success) whenRight,
  ) {
    return whenLeft(_value);
  }
}

class _Right<L, R> extends Either<L, R> {
  _Right(this._value);

  final R _value;

  @override
  bool get isLeft => false;

  @override
  bool get isRight => true;

  @override
  T when<T>(
    T Function(L error) whenLeft,
    T Function(R success) whenRight,
  ) {
    return whenRight(_value);
  }
}
