import 'dart:io';

import 'package:global_assert/global_assert.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';

void main() {
  test('true global asserts allow compilation', () {
    final result = Process.runSync('dart', [
      path.join(
        Directory.current.path,
        'example',
        'global_assert_example.dart',
      ),
    ]);

    expect(result.stderr, isEmpty);
    expect(result.stdout, 'val_1\n');
    expect(result.exitCode, 0);
  });

  test('false global asserts fail compilation', () {
    final result = Process.runSync('dart', [
      '--define=BUILD_TIME_STRING=foo',
      path.join(
        Directory.current.path,
        'example',
        'global_assert_example.dart',
      ),
    ]);

    expect(result.stdout, isEmpty);
    expect(
      result.stderr,
      contains(
        'This assertion failed with message: '
        'buildTimeString must be one of "val_1" or "val_2".\n',
      ),
    );
    expect(result.exitCode, 254);
  });
}

@Assert(true, 'message')
const foo = 'foo';
