import 'package:global_assert/global_assert.dart';

@Assert(
  buildTimeString == 'val_1' || buildTimeString == 'val_2',
  'buildTimeString must be one of "val_1" or "val_2".',
)
const buildTimeString = String.fromEnvironment(
  'BUILD_TIME_STRING',
  defaultValue: 'val_1',
);

/// Try running this with:
///
/// ```dart
/// // prints 'val_1'
/// dart global_assert_example.dart
/// ```
///
/// ```dart
/// // prints 'val_2'
/// dart --define=BUILD_TIME_STRING=val_2 global_assert_example.dart
/// ```
///
/// ```dart
/// // compilation error
/// dart --define=BUILD_TIME_STRING=foo global_assert_example.dart
/// ```
void main() {
  print(buildTimeString);
}
