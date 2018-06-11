# Either

This is a Swift microframework providing `Either<Left, Right>` and `EitherProtocol`, with generic implementations of `==`/`!=` where `Left` & `Right`: `Equatable`.

`Either` allows you to specify that a value should be one of two types, or that that a value of a single type should have one of two semantics. For example, `Either<Int, NSError>` might be the result of a computation which could fail, while `Either<String, String>` might mean that you want to handle a string in one of two different ways.

`EitherProtocol` is an easy-to-adopt protocol (it requires one method and two constructor functions) which allows clients to generically use `Either` or conforming `Result`, etc. types.


## Use

Constructing an `Either`:

```swift
// Wrap:
let left = Either<Int, String>.left(4)
let right = Either<Int, String>.right("four")
```

Extracting the value:

```swift
// Unwrap:
let value = left.either(ifLeft: { $0 }, ifRight: { $0.characters.count })
```

Representing success/failure:

```swift
let result = someComputation() // result has type `Either<Error, T>`
let success = result.right // success has type `T?`
let error = result.left    // error has type `Error?`
```

However, you might instead prefer to use a [more tailored `Result`](https://github.com/antitypical/Result) type. Even if it doesn’t conform to `EitherProtocol` already, you can implement conformance in your application:

```swift
extension Result: EitherProtocol { // Result<T, Error>
	static func toLeft(_ value: Error) -> Result {
		return Result(error: value)
	}

	static func toRight(value: T) -> Result {
		return Result(value: value)
	}

	func either<Result>(ifLeft: (Error) -> Result, ifRight: (T) -> Result) -> Result {
		switch self {
		case let .success(x):
			return g(x)
		case let .failure(error):
			return f(error)
		}
	}
}
```

Now you can use generic functions like `==`, `!=`, and any you might write with both `Either` and `Result`.

API documentation is in the source.


## Integration

1. Add this repository as a submodule and check out its dependencies, and/or [add it to your Cartfile](https://github.com/Carthage/Carthage/blob/master/Documentation/Artifacts.md#cartfile) if you’re using [carthage](https://github.com/Carthage/Carthage/) to manage your dependencies.
2. Drag `Either.xcodeproj` into your project or workspace, and do the same with its dependencies (i.e. the other `.xcodeproj` files included in `Either.xcworkspace`). NB: `Either.xcworkspace` is for standalone development of Either, while `Either.xcodeproj` is for targets using Either as a dependency.
3. Link your target against `Either.framework` and each of the dependency frameworks.
4. Application targets should ensure that the framework gets copied into their application bundle. (Framework targets should instead require the application linking them to include Either and its dependencies.)

Or use the Swift package manager and add this to you `Package.swift` file:  
```
  ...
  dependencies: [
    ...  
    .package(url: "https://github.com/robrix/Either", "2.0.1" ..< "3.0.0")
  ],
  targets: [
    ...
    .target(
        name: "<YourTargetName>",
        dependencies: ["Either"]),
  ]
```