import 'package:either/either.dart';
import 'package:test/test.dart';

void main() {
  test('left', () {
    final either = left(0);
    expect(either.isLeft, true);
    expect(either.isRight, false);
    expect(either.when(id, id), equals(0));
  });

  test('right', () {
    final either = right(1);
    expect(either.isLeft, false);
    expect(either.isRight, true);
    expect(either.when(id, id), equals(1));
  });

  test('map', () {
    final error = left(0);
    final success = right(0);

    final errorMap = error.map((r) => r + 1);
    final successMap = success.map((r) => r + 1);

    expect(errorMap.when(id, id), equals(0));
    expect(successMap.when(id, id), equals(1));
  });

  test('mapError', () {
    final error = left(0);
    final success = right(0);

    final errorMap = error.mapError((l) => l + 1);
    final successMap = success.mapError((l) => l + 1);

    expect(errorMap.when(id, id), equals(1));
    expect(successMap.when(id, id), equals(0));
  });

  test('flatMap', () {
    final error = left(0);
    final success = right(0);

    final a = error.flatMap((r) => right(r + 2));
    final b = success.flatMap((r) => left(r + 1));
    final c = success.flatMap((r) => right(r + 2));

    expect(a.isLeft, isTrue);
    expect(b.isLeft, isTrue);
    expect(c.isRight, isTrue);
    expect(a.when(id, id), equals(0));
    expect(b.when(id, id), equals(1));
    expect(c.when(id, id), equals(2));
  });
}
