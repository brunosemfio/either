import 'package:either/either.dart';
import 'package:either/src/async_either.dart';
import 'package:test/test.dart';

void main() {
  test('map', () async {
    final error = Future.value(left(0));
    final success = Future.value(right(0));

    final errorMap = await error.map((r) => r + 1);
    final successMap = await success.map((r) => r + 1);

    expect(errorMap.when(id, id), equals(0));
    expect(successMap.when(id, id), equals(1));
  });

  test('mapError', () async {
    final error = Future.value(left(0));
    final success = Future.value(right(0));

    final errorMap = await error.mapError((l) => l + 1);
    final successMap = await success.mapError((l) => l + 1);

    expect(errorMap.when(id, id), equals(1));
    expect(successMap.when(id, id), equals(0));
  });

  test('flatMap', () async {
    final error = Future.value(left(0));
    final success = Future.value(right(0));

    final a = await error.flatMap((r) async => right(r + 2));
    final b = await success.flatMap((r) async => left(r + 1));
    final c = await success.flatMap((r) async => right(r + 2));

    expect(a.isLeft, isTrue);
    expect(b.isLeft, isTrue);
    expect(c.isRight, isTrue);
    expect(a.when(id, id), equals(0));
    expect(b.when(id, id), equals(1));
    expect(c.when(id, id), equals(2));
  });
}
