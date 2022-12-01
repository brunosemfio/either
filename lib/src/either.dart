import 'dart:async';

T id<T>(T value) => value;

Either<L, R> left<L, R>(L l) => _Left<L, R>(l);

Either<L, R> right<L, R>(R r) => _Right<L, R>(r);

abstract class Either<L, R> {
  bool get isLeft;
  bool get isRight;

  T fold<T>(T Function(L error) lf, T Function(R success) rf);

  Either<L, T> map<T>(T Function(R r) rf);

  Future<Either<L, T>> mapAsync<T>(FutureOr<T> Function(R r) rf);

  Either<L, T> then<T>(Either<L, T> Function(R r) rf);

  Future<Either<L, T>> thenAsync<T>(FutureOr<Either<L, T>> Function(R r) rf);
}

class _Left<L, R> extends Either<L, R> {
  _Left(this._value);

  final L _value;

  @override
  bool get isLeft => true;

  @override
  bool get isRight => false;

  @override
  T fold<T>(T Function(L _) f, _) => f(_value);

  @override
  Either<L, T> map<T>(_) => _Left(_value);

  @override
  Future<Either<L, T>> mapAsync<T>(_) => Future.value(_Left(_value));

  @override
  Either<L, T> then<T>(_) => _Left(_value);

  @override
  Future<Either<L, T>> thenAsync<T>(_) => Future.value(_Left(_value));
}

class _Right<L, R> extends Either<L, R> {
  _Right(this._value);

  final R _value;

  @override
  bool get isLeft => false;

  @override
  bool get isRight => true;

  @override
  T fold<T>(_, T Function(R _) f) => f(_value);

  @override
  Either<L, T> map<T>(T Function(R _) f) => _Right(f(_value));

  @override
  Future<Either<L, T>> mapAsync<T>(FutureOr<T> Function(R _) f) =>
      Future.value(f(_value)).then((value) => _Right(value));

  @override
  Either<L, T> then<T>(Either<L, T> Function(R _) f) => f(_value);

  @override
  Future<Either<L, T>> thenAsync<T>(FutureOr<Either<L, T>> Function(R _) f) =>
      Future.value(f(_value));
}
