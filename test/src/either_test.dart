import 'package:either/either.dart';
import 'package:test/test.dart';

void main() {
  test('left', () {
    final either = left(0);
    expect(either.isLeft, true);
    expect(either.isRight, false);
    expect(either.fold(id, id), equals(0));
  });

  test('right', () {
    final either = right(1);
    expect(either.isLeft, false);
    expect(either.isRight, true);
    expect(either.fold(id, id), equals(1));
  });

  test('map', () {
    final a = left(0);
    final b = right(0);

    final c = a.map((r) => r + 1);
    final d = b.map((r) => r + 1);

    expect(c.fold(id, id), equals(0));
    expect(d.fold(id, id), equals(1));
  });

  test('mapAsync', () async {
    final a = left(0);
    final b = right(0);

    final c = await a.mapAsync((r) => r + 1);
    final d = await b.mapAsync((r) async => r + 1);

    expect(c.fold(id, id), equals(0));
    expect(d.fold(id, id), equals(1));
  });

  test('then', () {
    final a = left(0);
    final b = right(0);

    final c = a.then((r) => right(r + 2));
    final d = b.then((r) => left(r + 1));
    final e = b.then((r) => right(r + 2));

    expect(c.isLeft, isTrue);
    expect(d.isLeft, isTrue);
    expect(e.isRight, isTrue);
    expect(c.fold(id, id), equals(0));
    expect(d.fold(id, id), equals(1));
    expect(e.fold(id, id), equals(2));
  });

  test('thenAsync', () async {
    final a = left(0);
    final b = right(0);

    final c = await a.thenAsync((r) => right(r + 2));
    final d = await b.thenAsync((r) async => left(r + 1));
    final e = await b.thenAsync((r) async => right(r + 2));

    expect(c.isLeft, isTrue);
    expect(d.isLeft, isTrue);
    expect(e.isRight, isTrue);
    expect(c.fold(id, id), equals(0));
    expect(d.fold(id, id), equals(1));
    expect(e.fold(id, id), equals(2));
  });
}
