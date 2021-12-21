A micro-library for asserting at build time.

[![pub package](https://img.shields.io/pub/v/global_assert.svg)](https://pub.dev/packages/global_assert)
[![Build Status](https://github.com/cmc5788/global_assert/workflows/build/badge.svg)](https://github.com/cmc5788/global_assert/actions)
[![Coverage](https://gist.githubusercontent.com/cmc5788/c702c60ffc1bed677a7e9091291cdf7a/raw/5a619c2f4bd0b7bb058648cfc525822a5ffeea6d/coverage_badge.svg)](https://github.com/cmc5788/global_assert/actions)

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

### 🤔 How does this even work?!

The Dart compiler invokes annotation constructors at compile-time. This micro-library takes advantage of that to "trick" the compiler into allowing build-time asserts that can be placed (almost) anywhere. Special thanks to [Kyle Turney](https://github.com/kturney) for the inspiration behind this approach.

### Why not allow an assert without a message?

Unfortunately, [Dart doesn't treat an assert with a null message the same as an assert without any message at all](https://github.com/dart-lang/sdk/issues/47994). This means that we would need two constructors for `@Assert` to enable both messageless asserts and asserts with messages. Instead, we made the design choice when creating this micro-library that `@Assert` should require a non-null message. This enforces more meaningful compilation failure messages.

### Will this always be needed?

We expect that [when Dart supports metaprogramming](https://github.com/dart-lang/language/issues/1565), this library will be deprecated.
