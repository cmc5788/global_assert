A micro-library for asserting at build time.

[![Build Status](https://github.com/cmc5788/global_assert/workflows/build/badge.svg)](https://github.com/cmc5788/global_assert/actions)

It's a common practice to configure a Dart app using `const` (build-time) values. There are benefits to this approach, such as enabling [tree shaking](https://github.com/dart-lang/sdk/issues/33920) of unused code.

This library makes it easy to do build-time assertions about such constants so that misconfigured apps fail at build-time instead of failing at runtime.

## Usage

Use this library to validate your app's `const` values at build time. Anything can be annotated with `@Assert`.

```dart
//
// This app will fail compilation with '--define=MY_VAL=foo'
//

@Assert(
  myBuildTimeVal == 'val1' || myBuildTimeVal == 'val2',
  'myBuildTimeVal must be one of "val1" or "val2"',
)
const myBuildTimeVal = String.fromEnvironment('MY_VAL');

void main() {
  print('myBuildTimeVal is "$myBuildTimeVal"');
}
```

## FAQ

### Why not allow an assert without a message?

Unfortunately, Dart doesn't treat an assert with a null message the same as an assert without any message at all. This means that we would need two constructors for `@Assert` to enable both messageless asserts and asserts with messages. Instead, we made the design choice when creating this micro-library that `@Assert` should require a non-null message. This enforces more meaningful compilation failure messages.

### Will this always be needed?

We expect that [when Dart supports metaprogramming](https://github.com/dart-lang/language/issues/1565), this library will be deprecated.