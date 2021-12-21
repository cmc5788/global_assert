/// Annotation util for performing build time asserts in the global namespace.
/// This is useful for validating compile-time constants in a way that fails
/// early, before runtime.
///
/// For example:
///
/// ```dart
/// @Assert(
///   myBuildTimeVal == 'val_a' || myBuildTimeVal == 'val_b',
///   'myBuildTimeVal must be one of "val_a" or "val_b"',
/// )
/// const myBuildTimeVal = String.fromEnvironment('MY_VAL');
///
/// // Running this with '--define=MY_VAL=foo' will fail compilation.
/// void main() {
///   print('myBuildTimeVal is $myBuildTimeVal');
/// }
/// ```
class Assert {
  /// Perform an [Assert] with a message.
  const Assert(bool condition, String message) : assert(condition, message);
}
